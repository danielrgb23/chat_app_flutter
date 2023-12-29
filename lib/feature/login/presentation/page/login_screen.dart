import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 500), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Welcome to Chat App'),
    );
  }

  _buildBody(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          top: mq.height * .15,
          right: isAnimated ? mq.width * .25 : -mq.width * .5,
          width: mq.width * .5,
          duration: const Duration(seconds: 1),
          child: Image.asset('assets/images/chat-de-voz.png'),
        ),
        Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.height * .07,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 131, 206, 134),
              shape: const StadiumBorder(),
              elevation: 1,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                'initScream',
              );
            },
            icon: Image.asset(
              'assets/images/google.png',
              height: mq.height * 0.06,
            ),
            label: RichText(
                text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                  TextSpan(text: 'Login with '),
                  TextSpan(
                      text: 'Google',
                      style: TextStyle(fontWeight: FontWeight.w500))
                ])),
          ),
        ),
      ],
    );
  }
}
