import 'dart:developer';

import 'package:chat_app/core/apis/apis.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      if (APIs.auth.currentUser != null) {
        log('\nUser: ${APIs.auth.currentUser}');
        //navigate to initial screen
        Navigator.pushReplacementNamed(context, 'initScream');
      } else {
        //navigate to login screen
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: mq.height * .15,
          right: mq.width * .25,
          width: mq.width * .5,
          child: Image.asset('assets/images/chat-de-voz.png'),
        ),
        Positioned(
          bottom: mq.height * .15,
          width: mq.width,
          child: const Text(
            'MADE IN BRAZIL WITH ❤️',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: Colors.black87, letterSpacing: .5),
          ),
        ),
      ],
    );
  }
}
