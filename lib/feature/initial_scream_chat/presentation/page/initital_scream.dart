import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InititalScream extends StatefulWidget {
  const InititalScream({Key? key}) : super(key: key);

  @override
  _InititalScreamState createState() => _InititalScreamState();
}

class _InititalScreamState extends State<InititalScream> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
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
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_comment_rounded),
      ),
    );
  }
}
