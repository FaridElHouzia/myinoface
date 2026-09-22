import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LoadingDialog extends StatelessWidget {

  static void show({Key? key}) {
    final ctx = Get.overlayContext;
    if (ctx != null) {
      showDialog<void>(
        context: ctx,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      );
    }
  }

  static void hide() {
    final ctx = Get.overlayContext;
    if (ctx != null) {
      Navigator.pop(ctx);
    }
  }

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
