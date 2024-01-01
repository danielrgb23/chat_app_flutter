import 'package:chat_app/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  // sign out function
  _signin() async {
    await Constants.auth.signOut();
    await GoogleSignIn().signOut();
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: const Icon(CupertinoIcons.home),
      title: const Text('Chat App'),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ],
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: .0),
      child: FloatingActionButton(
        onPressed: () {
          _signin();
        },
        child: const Icon(Icons.add_comment_rounded),
      ),
    );
  }
}
