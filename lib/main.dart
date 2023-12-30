import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/config/theme/app_theme.dart';
import 'package:chat_app/feature/login/presentation/page/login_screen.dart';
import 'package:chat_app/feature/splash/presentation/pages/splash_scream.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//global object for accessing device screen size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializerFirebase();
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
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const SplashScreem(),
    );
  }
}

_initializerFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
