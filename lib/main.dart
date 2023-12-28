import 'package:chat_app/config/theme/app_theme.dart';
import 'package:chat_app/feature/initial_scream_chat/presentation/page/initital_scream.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: InititalScream(),
    );
  }
}
