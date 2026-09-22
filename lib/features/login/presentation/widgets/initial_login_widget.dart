import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:myinoface/features/login/domain/usecases/input_qrcode_model.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/presentation/bloc/login_bloc.dart';
import '../../../forgot_pass/presentation/pages/forgot_pass_page.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:myinoface/core/usecases/firebase_notifications.dart';
import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/util/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myinoface/core/util/keys.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class InitialLoginWidget extends StatefulWidget {
  final TextEditingController identifiantController;
  final TextEditingController passwordController;
  final TextEditingController codeController;

  const InitialLoginWidget({
    required this.identifiantController,
    required this.passwordController,
    required this.codeController,
    Key? key,
  }) : super(key: key);

  @override
  _InitialLoginWidgetState createState() => _InitialLoginWidgetState();
}

class _InitialLoginWidgetState extends State<InitialLoginWidget>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController animController;
  late Animation<double> animation;

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  void _initAnimation() {
    try {
      final cached = PreferenceUtils.getInputLogin();
      widget.identifiantController.text = cached?.identifiant ?? '';
      widget.codeController.text = '';
      animController = AnimationController(
          duration: const Duration(seconds: 5), vsync: this);
      final curvedAnimation = CurvedAnimation(
        parent: animController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      );

      animation =
          Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                animController.reverse();
              } else if (status == AnimationStatus.dismissed) {
                animController.forward();
              }
            });
      animController.forward();
    } catch (e) {
      animController.dispose();
      logger.e(e);
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
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 30),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: FadeTransition(
                      opacity: animation,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset(
                          IMG.logo,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: widget.identifiantController,
                    decoration: InputDecoration(
                      labelText: 'identifiant'.tr,
                      icon: Icon(MdiIcons.account),
                    ),
                    validator: (val) {
                      if (val?.isEmpty ?? true) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: widget.passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'password'.tr,
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (val) {
                      if (val?.isEmpty ?? true) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: widget.codeController,
                    decoration: InputDecoration(
                      labelText: 'code_school'.tr,
                      icon: Icon(MdiIcons.homeCity),
                    ),
                    validator: (val) {
                      if (val?.isEmpty ?? true) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(MdiIcons.account),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ))),
                    label: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            Get.locale.toString().contains("fr") ? 14 : 10,
                        vertical:
                            Get.locale.toString().contains("fr") ? 14 : 10,
                      ),
                      child: Text('login'.tr),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState?.validate() ?? false) {
                        await PreferenceUtils.setString(
                            Keys.codeSchool, widget.codeController.text.trim());
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginWithEmailAndPass(
                          inputLogin: InputLoginModel(
                            tokenmobile: await FirebaseNotifications.getToken() ?? '',
                            identifiant: widget.identifiantController.text.trim(),
                            motdepasse: appUtils.generateMd5(
                              widget.passwordController.text.trim(),
                            ),
                          ),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton.icon(
                    icon: Icon(MdiIcons.qrcodeScan, color: Colors.white),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ))),
                    onPressed: initQR,
                    label: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            Get.locale.toString().contains("fr") ? 14 : 10,
                        vertical:
                            Get.locale.toString().contains("fr") ? 14 : 10,
                      ),
                      child: Text(
                        'login_qr'.tr,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Get.to(() => const ForgotPassPage()),
                    child: Text(
                      'forgot_pass'.tr,
                      style: subTextStyle,
                    ),
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

  Future<void> initQR() async {
    try {
      final String? barcodeScanRes = await Navigator.of(context).push<String>(
        MaterialPageRoute(
          builder: (context) => AiBarcodeScanner(
            onDetect: (BarcodeCapture capture) {
              Navigator.of(context).pop(capture.barcodes.first.rawValue);
            },
          ),
        ),
      );
      if (!mounted) return;
      if (barcodeScanRes != null &&
          barcodeScanRes.isNotEmpty &&
          barcodeScanRes != '-1') {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithQRCode(
              inputQrcode: InputQrcodeModel(
            scancode: barcodeScanRes,
            tokenmobile: await FirebaseNotifications.getToken() ?? '',
          )),
        );
      }
    } on PlatformException {
      // Failed to scan barcode
    }
  }
}
