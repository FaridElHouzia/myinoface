import 'package:myinoface/features/login/presentation/pages/login_page.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import 'package:myinoface/features/pages/home_page.dart';
import 'package:myinoface/core/ui/splash_app.dart';
import 'package:flutter/material.dart';


class LoadedLoginWidget extends StatelessWidget {
  final LoginModel model;
  const LoadedLoginWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!model.erreur) {
      return SplashApp(
        home: const HomePage(),
        duration: 1000,
        type: AnimatedSplashType.StaticDuration,
      );
    } else {
      return SplashApp(
        home: const LoginPage(),
        duration: 1000,
        type: AnimatedSplashType.StaticDuration,
      );
    }
  }
}
