import 'dart:developer';

import 'package:chat_app/feature/login/presentation/bloc/controller/controller_auth.dart';
import 'package:chat_app/helpers/dialogs.dart';
import 'package:chat_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAnimated = false;

  final LoginScreenController _loginScreenController = LoginScreenController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  // _handleGoogleBtnClick() {
  //   signInWithGoogle().then((user) {
  //     log('\nUser: ${user.user}');
  //     log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
  //     Navigator.pushReplacementNamed(
  //       context,
  //       'initScream',
  //     );
  //   });
  // }

  // Future<UserCredential> signInWithGoogle() async {
  //   //Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   //Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   //Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   //Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // sign out function
  _signin() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final LoginScreenController controller;
    // mq = MediaQuery.of(context).size;
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
              backgroundColor: const Color.fromARGB(255, 131, 206, 134),
              shape: const StadiumBorder(),
              elevation: 1,
            ),
            onPressed: () {
              _loginScreenController
                  .handleGoogleBtnClick(context);
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
