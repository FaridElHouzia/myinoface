import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/presentation/pages/login_page.dart';
import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:myinoface/core/notifier/model_notifier.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/ui/error_app.dart';
import 'package:myinoface/core/util/keys.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




AnimatedSplashType? _runfor;
Function? _customFunction;
String? _imagePath;
int? _duration;
Widget? _home;


enum AnimatedSplashType { StaticDuration, BackgroundProcess }

Map<dynamic, Widget> _outputAndHome = {};

class SplashApp extends StatefulWidget {

  SplashApp({
    Key? key,
    required Widget home,
    required int duration,
    required AnimatedSplashType type,
    Map<dynamic, Widget>? outputAndHome
  }) : super(key: key) {
    _home = home;
    _duration = duration;
    _runfor = type;
    _outputAndHome = outputAndHome??{};
  }

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    if ((_duration??0) < 1000) _duration = 2000;
    _initAnimation();
    _navigator();
  }

  void _initAnimation() {
    try {
      _animationController = AnimationController(
          duration: const Duration(seconds: 5), vsync: this);
      final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      );

      _animation = Tween<double>(
          begin: 0, end: 1).animate(curvedAnimation);
      _animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
      _animationController.forward();
    } catch(e) {
      _animationController.dispose();
    }
  }

  Future<void> _navigator() async {
    // try {
      await networkLogic.hasConnection();
      if (networkState.isConnected && context.mounted) {
        final notify = context.read<ModelNotifier>();
        InputLoginModel? login = PreferenceUtils.getInputLogin();
        if (login != null) {
          notify.setInputLogin(login);
          if (PreferenceUtils.getString(Keys.codeSchool).trim().isEmpty) {
            Get.offAll(() => const LoginPage());
            return;
          }
          final classes = await appUtils.getAllClasses();
          if (classes.erreur && classes.message.contains('Votre Identifiant / mot de passe est invalide !')) {
            await appUtils.logOut();
            Get.offAll(() => const LoginPage());
            return;
          }
          notify.setClassesModel(classes);
          try {
            final allGardesModel = await appUtils.getAllGardes();
            notify.setAllGardesModel(allGardesModel);
          } catch (e) {
            logger.e(e);
          }
        }
        Get.offAll(() => (login != null) ? _home! : const LoginPage());
      } else {
        Get.offAll(() => ErrorApp(message: 'error_connection'.tr));
      }
    // } catch(e) {
    //   logger.e(e);
    //   Get.offAll(() => ErrorApp(message: 'something_wrong'.tr));
    // }
  }


  @override
  void dispose() {
    // _animation.d
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20.0),
            child: Image.asset(
              IMG.logo,
              width: Get.width/3,
            ),
          ),
        ),
      ),
    );
  }
}
