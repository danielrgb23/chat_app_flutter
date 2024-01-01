import 'dart:developer';

import 'package:chat_app/feature/login/domain/usecases/google_sign_in_usecase.dart';
import 'package:chat_app/helpers/dialogs.dart';
import 'package:flutter/material.dart';

class LoginScreenController {
  final GoogleSignInUseCase _googleSignInUseCase;
  final ValueNotifier<String> errorMessage = ValueNotifier<String>('');

  LoginScreenController({GoogleSignInUseCase? googleSignInUseCase})
      : _googleSignInUseCase = googleSignInUseCase ?? GoogleSignInUseCase();

  Future<void> handleGoogleBtnClick(BuildContext context) async {
    //For showing progress bar
    Dialogs.showProgressBar(context);
    _googleSignInUseCase.signInWithGoogle(context).then((user) {
      Navigator.pop(context);
      if (user != null) {
        // Log adicional de informações do usuário
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        Navigator.pushReplacementNamed(
          context,
          'initScream',
        );
      }
    });
    // Faça algo com o usuário retornado (exibição, navegação, etc.)
  }
}
