import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:myinoface/core/ui/responsive_safe_area.dart';
import 'package:myinoface/features/pages/home_page.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/ui/loading_dialog.dart';
import 'package:myinoface/core/ui/splash_app.dart';
import 'package:myinoface/core/util/img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ErrorApp extends StatelessWidget {
  final String?message;
  const ErrorApp({this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.pink,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('oops'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Image.asset(IMG.error, height: Get.height/3),
                  const SizedBox(height: 5,),
                  Text(message ?? 'something_wrong'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: Icon(MdiIcons.refresh),
                    label: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text('try_again'.tr),
                    ),
                    onPressed: () {
                      Get.offAll(() => SplashApp(
                        duration: 1000,
                        home: const HomePage(),
                        type: AnimatedSplashType.StaticDuration,
                      ));
                    },
                  ),
                  const SizedBox(height: 8,),
                  ElevatedButton.icon(
                    icon: Icon(MdiIcons.alert),
                    label: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text('rest'.tr),
                    ),
                    onPressed: () async {
                      LoadingDialog.show();
                      await appUtils.logOut();
                      LoadingDialog.hide();
                      Get.offAll(() => SplashApp(
                        duration: 1000,
                        home: const HomePage(),
                        type: AnimatedSplashType.StaticDuration,
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
