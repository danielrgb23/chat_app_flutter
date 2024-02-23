import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/apis/apis.dart';
import 'package:chat_app/feature/chat_screen/presentation/page/chat_screen.dart';
import 'package:chat_app/helpers/my_date_util.dart';
import 'package:chat_app/models/chat_user_model.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUserModel user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  MessageModel? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.02, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // color: Colors.blue.shade100,
      elevation: .5,
      child: InkWell(
          onTap: () {
            //for navigating to chat screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user)));
          },
          child: StreamBuilder(
              stream: APIs.getLastMessage(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list = data
                        ?.map((e) => MessageModel.fromJson(e.data()))
                        .toList() ??
                    [];
                if (list.isNotEmpty) _message = list[0];

                return ListTile(
                  //user profile picture
                  // leading: ,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .3),
                    child: CachedNetworkImage(
                      width: mq.height * .055,
                      height: mq.height * .055,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),

                  //user name
                  title: Text(widget.user.name),

                  //last message
                  subtitle: Text(
                      _message != null ? _message!.msg : widget.user.about,
                      maxLines: 1),

                  //last message time
                  trailing: _message == null
                      ? null //show nothing when no message is sent
                      : _message!.read.isEmpty &&
                              _message!.fromId != APIs.user.uid
                          ?
                          //show for unread message
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreenAccent.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          :
                          //message sent time
                          Text(
                              MyDateUtil.getLastMessageTime(
                                  context: context, time: _message!.sent),
                              style: const TextStyle(color: Colors.black)),
                );
              })),
    );
  }
}
