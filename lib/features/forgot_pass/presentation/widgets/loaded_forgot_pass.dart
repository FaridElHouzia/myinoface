import '../../domain/entities/forgot_pass_entity.dart';
import '../../../../core/util/img.dart';
import 'package:flutter/material.dart';
import 'initial_forgot_pass.dart';


class LoadedForgotPass extends StatelessWidget {

  final ForgotPassEntity entity;
  const LoadedForgotPass(this.entity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!entity.erreur) {
      return Scaffold(
        body: Center(
          child: Image.asset(IMG.logo),
        ),
      );
    } else {
      return const InitialForgotPass();
    }
  }
}
