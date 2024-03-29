import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/apis/apis.dart';
import 'package:chat_app/feature/chat_screen/presentation/widget/message_card.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final ChatUserModel user;
  const ChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  List<MessageModel> _list = [];

  //for hadling message text changes
  final _textController = TextEditingController();

  //for storing value of showing or hiding emoji
  bool _showEmoji = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() {
                _showEmoji = !_showEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 234, 248, 255),
            appBar: buildAppBar(context),
            body: _buildBody(context),
          ),
        ),
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: _appBar(),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: APIs.getAllMessages(widget.user),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                //if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const SizedBox();

                //if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final data = snapshot.data?.docs;
                    _list = data
                            ?.map((e) => MessageModel.fromJson(e.data()))
                            .toList() ??
                        [];
                  }

                  if (_list.isNotEmpty) {
                    return ListView.builder(
                        itemCount: _list.length,
                        padding: EdgeInsets.only(top: mq.height * .01),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MessageCard(
                            message: _list[index],
                          );
                        });
                  } else {
                    return const Center(
                      child: Text(
                        'Say hii! 👋',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
              }
            },
          ),
        ),

        //chat input field
        _chatInput(),

        // show emojis on keyboard emoji button click & vice versa
        if (_showEmoji)
          SizedBox(
            height: mq.height * .35,
            child: EmojiPicker(
              textEditingController: _textController,
              config: Config(
                bgColor: const Color.fromARGB(255, 234, 248, 255),
                columns: 7,
                emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
              ),
            ),
          )
      ],
    );
  }

// app bar widget
  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          // back button
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black54)),

          //user profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: mq.height * .05,
              height: mq.height * .05,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),

          // for adding some space
          const SizedBox(width: 10),

          //user name and last seen time
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //user name
              Text(widget.user.name,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500)),

              // for adding some space
              const SizedBox(height: 2),

              //last seen time of user
              const Text("Last seen not avaliable",
                  style: TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          )
        ],
      ),
    );
  }

//botton chat input field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.blueAccent,
                        size: 25,
                      )),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: "Type something...",
                        hintStyle: TextStyle(
                          color: Colors.blueAccent,
                        ),
                        border: InputBorder.none),
                  )),

                  // pick image from gallery button
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image,
                        color: Colors.blueAccent,
                        size: 26,
                      )),

                  // take image from camera button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          log("Image Path: ${image.path}}");

                          await APIs.sendChatImage(
                              widget.user, File(image.path));
                        }
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.blueAccent,
                        size: 26,
                      )),

                  // for adding some space
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),
          //send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text, Type.text);
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
