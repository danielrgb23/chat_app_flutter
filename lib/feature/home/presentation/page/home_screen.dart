import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/feature/home/data/model/chat_user_model.dart';
import 'package:chat_app/feature/home/presentation/widgets/chat_user_card.dart';
import 'package:chat_app/feature/profile/presentation/page/profile_screen.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUserModel> list = [];

  @override
  void initState() {
    super.initState();
    Constants.getSelfInfo();
  }

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
      leading: const Icon(CupertinoIcons.home),
      title: const Text('Chat App'),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileScreen(
                  user: Constants.me,
                );
              }));
            },
            icon: const Icon(Icons.more_vert))
      ],
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
        onPressed: () {
          _signin();
        },
        child: const Icon(Icons.add_comment_rounded),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: Constants.getAllUsers(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          //if data is loading
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const Center(
              child: CircularProgressIndicator(),
            );

          //if some or all data is loaded then show it
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUserModel.fromJson(e.data())).toList() ??
                      [];
            }

            if (list.isNotEmpty) {
              return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index]);
                    // return Text('Name: ${list[index].name}');
                  });
            } else {
              return const Center(
                child: Text(
                  'No Connections Found!',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
        }
      },
    );
  }
}
