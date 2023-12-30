import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class SplashScreem extends StatefulWidget {
  const SplashScreem({Key? key}) : super(key: key);

  @override
  _SplashScreemState createState() => _SplashScreemState();
}

class _SplashScreemState extends State<SplashScreem> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 1500), () {
      Navigator.pushReplacementNamed(context, 'initScream');
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
              fontSize: 16,
              color: Colors.black87,
              letterSpacing: .5
            ),
          ),
        ),
      ],
    );
  }
}
