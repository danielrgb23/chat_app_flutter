import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/feature/home/data/model/chat_user_model.dart';
import 'package:chat_app/feature/home/presentation/widgets/chat_user_card.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUserModel user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
      body: _buildBody(context),
    );
  }

  // sign out function
  _signin() async {
    await Constants.auth.signOut();
    await GoogleSignIn().signOut();
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Profile Screen'),
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          await _signin();
        },
        icon: const Icon(Icons.logout),
        label: const Text("Loggout"),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
      child: Column(
        children: [
          //for adding some spacing
          SizedBox(width: mq.width, height: mq.height * .03),

          //user profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .1),
            child: CachedNetworkImage(
              width: mq.height * .2,
              height: mq.height * .2,
              fit: BoxFit.fill,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),

          //for adding some spacing
          SizedBox(height: mq.height * .03),

          Text(
            widget.user.email,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),

          //for adding some spacing
          SizedBox(height: mq.height * .05),

          TextFormField(
            initialValue: widget.user.name,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                hintText: "eg. Happy Singh",
                label: const Text("Name")),
          ),

          //for adding some spacing
          SizedBox(height: mq.height * .02),

          TextFormField(
            initialValue: widget.user.about,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                ),
                hintText: "eg. Feeling Happy",
                label: const Text("About")),
          ),

          //for adding some spacing
          SizedBox(height: mq.height * .05),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: Size(mq.width * .5, mq.height * .06)),
            onPressed: () {},
            icon: const Icon(Icons.edit, size: 28,),
            label: const Text(
              "UPDATE",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
