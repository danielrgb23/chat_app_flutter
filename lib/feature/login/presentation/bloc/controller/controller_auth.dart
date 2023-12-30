import 'dart:developer';

import 'package:chat_app/feature/login/domain/usecases/google_sign_in_usecase.dart';
import 'package:flutter/material.dart';

class LoginScreenController {
  final GoogleSignInUseCase _googleSignInUseCase;
  final ValueNotifier<String> errorMessage = ValueNotifier<String>('');

  LoginScreenController({GoogleSignInUseCase? googleSignInUseCase})
      : _googleSignInUseCase = googleSignInUseCase ?? GoogleSignInUseCase();

  Future<void> handleGoogleBtnClick() async {
      final user = await _googleSignInUseCase.signInWithGoogle();
      // Faça algo com o usuário retornado (exibição, navegação, etc.)
      if (user != null) {
        // Usuário logado com sucesso
        // Log adicional de informações do usuário
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

      } else {
        // Falha na autenticação
        errorMessage.value = 'Falha na autenticação';
      }
    
  }
}
