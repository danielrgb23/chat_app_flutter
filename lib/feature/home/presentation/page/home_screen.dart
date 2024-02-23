import 'package:chat_app/core/apis/apis.dart';
import 'package:chat_app/models/chat_user_model.dart';
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
  //for storing all users
  List<ChatUserModel> _list = [];

  // for storing search items
  final List<ChatUserModel> _searchList = [];

  //for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for hiding keyboard when a tap is detected on screen
      onTap: () => Focus.of(context).unfocus(),
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          floatingActionButton: _buildFloatingActionButton(context),
          body: _buildBody(context),
        ),
      ),
    );
  }

  // sign out function
  _signin() async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: const Icon(CupertinoIcons.home),
      title: _isSearching
          ? TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Name, E-mail, ..."),
              autofocus: true,
              style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
              //when search text changes then update search list
              onChanged: (value) {
                //search logic
                _searchList.clear();

                for (var i in _list) {
                  if (i.name.toLowerCase().contains(value.toLowerCase()) ||
                      i.email.toLowerCase().contains(value.toLowerCase())) {
                    _searchList.add(i);
                  }

                  setState(() {
                    _searchList;
                  });
                }
              },
            )
          : const Text('Chat App'),
      actions: [
        //search user button
        IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: Icon(_isSearching
                ? CupertinoIcons.clear_circled_solid
                : Icons.search)),

        //more featuers button
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileScreen(
                  user: APIs.me,
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
      stream: APIs.getAllUsers(),
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
              _list =
                  data?.map((e) => ChatUserModel.fromJson(e.data())).toList() ??
                      [];
            }

            if (_list.isNotEmpty) {
              return ListView.builder(
                  itemCount: _isSearching ? _searchList.length : _list.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(
                        user: _isSearching ? _searchList[index] : _list[index]);
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
