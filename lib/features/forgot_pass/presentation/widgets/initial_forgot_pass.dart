import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/input_forgot_pass.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/keys.dart';
import '../../../../core/util/img.dart';
import '../bloc/forgot_pass_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;



class InitialForgotPass extends StatefulWidget {
  const InitialForgotPass({Key? key}) : super(key: key);


  @override
  _InitialForgotPassState createState() => _InitialForgotPassState();
}

class _InitialForgotPassState extends State<InitialForgotPass> with SingleTickerProviderStateMixin {

  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController animController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  _initAnimation() {
    try {
      animController = AnimationController(
          duration: const Duration(seconds: 5), vsync: this);
      final curvedAnimation = CurvedAnimation(
        parent: animController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      );

      animation = Tween<double>(
          begin: 0, end: 2 * math.pi).animate(curvedAnimation)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            animController.forward();
          }
        }
      );

      animController.forward();
    } catch(e) {
      animController.dispose();
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
            color: Colors.pink,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: FadeTransition(
                      opacity: animation,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset(IMG.logo, height: 80,),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _identifiantController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'identifiant'.tr,
                      icon: Icon(MdiIcons.account),
                    ),
                    validator: (val) {
                      if(val?.isEmpty ?? true) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'email'.tr,
                      icon: Icon(MdiIcons.email),
                    ),
                    validator: (val) {
                      if(val?.isEmpty ?? true) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      labelText: 'code_school'.tr,
                      icon: Icon(MdiIcons.homeCity),
                    ),
                    validator: (val) {
                      if(val?.isEmpty ?? true) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton.icon(
                    icon: Icon(MdiIcons.lockReset),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )
                        )
                    ),
                    label: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text('init_pass'.tr),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState?.validate() ?? false) {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setString(Keys.codeSchool, _codeController.text.trim());
                        BlocProvider.of<ForgotPassBloc>(context).add(ForgotPass(
                          input: InputForgotPass(
                            identifiant: _identifiantController.text.trim(),
                            email: _emailController.text.trim(),
                          ),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}