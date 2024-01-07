import 'package:chat_app/feature/home/data/model/chat_user_model.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUserModel user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.02, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // color: Colors.blue.shade100,
      elevation: .5,
      child: InkWell(
        onTap: () {},
        child:  ListTile(
          //user profile picture
          leading: CircleAvatar(child: Icon(CupertinoIcons.person)),

          //user name
          title: Text(widget.user.name),

          //last message
          subtitle: Text(widget.user.about, maxLines: 1),

          //last message time
          trailing: Text('12:00 PM', style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
