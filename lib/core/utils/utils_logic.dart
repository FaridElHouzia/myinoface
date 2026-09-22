import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import '../../features/login/domain/usecases/input_login_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myinoface/core/util/enums.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../usecases/preference_utils.dart';
import '../model/parent_info_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../usecases/constants.dart';
import '../ui/loading_dialog.dart';
import '../util/url_service.dart';
import '../model/cin_model.dart';
import 'package:get/get.dart';
import 'utils_state.dart';
import 'dart:developer';
import 'dart:convert';
import 'dart:async';




class UtilsLogic extends GetxController implements GetxService {
  static UtilsLogic instance = Get.find();
  final state = UtilsState();

  @override
  void onInit() {
    initVersion();
    super.onInit();
  }


  Future<void> initVersion({bool listener = false}) async {
    final packageInfo = await PackageInfo.fromPlatform();
    state.version = packageInfo.version;
    if (listener) {
      update();
    }
  }



  void showSnack({required SnackBarType type, String? title, String? message, int seconds = 4}) {
    switch (type) {
      case SnackBarType.error:
        Get.snackbar(
          title ?? 'oops'.tr,
          message ?? 'error_wrong'.tr,
          icon: Icon(MdiIcons.alert, color: Colors.red[300]),
          backgroundColor: Colors.white,
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.red[300],
          borderWidth: 0.5,
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          duration: Duration(seconds: seconds),
        );
        return;
      case SnackBarType.unconnected:
        Get.snackbar(
          title ?? 'no_internet'.tr,
          'error_connection'.tr,
          icon: Icon(MdiIcons.wifiRemove, color: Colors.red[300]),
          backgroundColor: Colors.white,
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.red[300],
          borderWidth: 0.5,
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          duration: Duration(seconds: seconds),
        );
        return;
      case SnackBarType.connected:
        Get.snackbar(
          title ?? 'internet_available'.tr,
          message ?? 'you_connected_internet'.tr,
          icon: Icon(MdiIcons.wifi, color: Colors.green[300]),
          backgroundColor: Colors.white,
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.green[300],
          borderWidth: 0.5,
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          duration: Duration(seconds: seconds),
        );
        return;
      case SnackBarType.info:
        Get.snackbar(
          title ??  'oops'.tr,
          message ?? '',
          icon: Icon(MdiIcons.informationOutline, color: Colors.orangeAccent),
          backgroundColor: Colors.white,
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.orangeAccent,
          borderWidth: 0.5,
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          duration: Duration(seconds: seconds),
        );
        return;
      case SnackBarType.success:
        Get.snackbar(
          title ?? 'successfully'.tr,
          message ?? '',
          icon: Icon(MdiIcons.checkboxMarkedCircleOutline, color: Colors.green[300]),
          backgroundColor: Colors.white,
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.green[300],
          borderWidth: 0.5,
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          duration: Duration(seconds: seconds),
        );
        return;
      case SnackBarType.warning:
        Get.snackbar(
          title ?? 'warning'.tr,
          message ?? '',
          icon: Icon(MdiIcons.checkboxMarkedCircleOutline, color: Colors.orange[300]),
          backgroundColor: Colors.white,
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.orange[300],
          borderWidth: 0.5,
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          duration: Duration(seconds: seconds),
        );
        return;
    }
  }

  Future<Parent?> getParentsByid(BuildContext context, int idPersonne) async {
    try {
      setParent(null);
      if (networkState.isConnected) {
        LoadingDialog.show();
        InputLoginModel? login = PreferenceUtils.getInputLogin();
        var body = {
          'identifiant': login?.identifiant.replaceAll(' ', ''),
          'motdepasse': login?.motdepasse.replaceAll(' ', ''),
          'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
          'id_personne': idPersonne,
        };
        http.Response response = await http.post(
          Uri.parse(UrlService.getUrl(UrlService.GetParentsByid_ws)),
          body: {'inoface_ws': json.encode(body)},
        );
        LoadingDialog.hide();
        if (kDebugMode) {
          log('getParentsByid: ${response.body}');
        }

        if (response.statusCode == 200 && context.mounted) {
          final info = parentInfoModelFromJson(response.body);
          return await showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('parents'.tr,
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.zero,
              content: GetBuilder<UtilsLogic>(
                builder: (logic) {
                  if (info.parents.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: info.parents.map((e) {
                          return ListTile(
                            onTap: () => setParent(e),
                            title: Text('${e.prenom} ${e.nom} - ${e.lien}'),
                            leading: logic.state.parent == e ?
                            const Icon(Icons.circle, color: Colors.pink) :
                            const Icon(Icons.circle_outlined),
                          );
                        }).toList(growable: false),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('no_results_found'.tr,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              ),
              actions: [
                TextButton(
                  child: Text('cancel'.tr),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text('ok'.tr),
                  onPressed: () {
                    if (state.parent != null) {
                      Navigator.pop(context, state.parent);
                    }
                  }
                ),
              ],
            );
          });
        }
      }
    } catch(e) {
      LoadingDialog.hide();
      logger.e(e);
    }
  }

  Future<void> getParentCinByid(BuildContext context, Parent parent) async {
    try {
      if (networkState.isConnected) {
        LoadingDialog.show();
        InputLoginModel? login = PreferenceUtils.getInputLogin();
        var body = {
          'identifiant': login?.identifiant.replaceAll(' ', ''),
          'motdepasse': login?.motdepasse.replaceAll(' ', ''),
          'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
          'id_parent': parent.idParent,
        };
        http.Response response = await http.post(
          Uri.parse(UrlService.getUrl(UrlService.GetParentCinByid_ws)),
          body: {'inoface_ws': json.encode(body)},
        );
        LoadingDialog.hide();
        if (kDebugMode) {
          log('getParentCinByid: ${response.body}');
        }


        if (response.statusCode == 200 && context.mounted) {
          final model = cinModelFromJson(response.body);
          final cinRecto = UrlService.rewriteInoserUriOrNull(model.cin?.cinRecto);
          final cinVerso = UrlService.rewriteInoserUriOrNull(model.cin?.cinVerso);
          if (cinRecto != null || cinVerso != null) {
            await showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text('CIN'.tr,
                  textAlign: TextAlign.center,
                ),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (cinRecto != null)
                      CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        imageUrl: cinRecto,
                        // height: 130,
                        width: Get.width,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),

                      if (cinVerso != null)
                        CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: cinVerso,
                          // height: 130,
                          width: Get.width,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('ok'.tr),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            });
          }
        }
      }
    } catch(e) {
      LoadingDialog.hide();
      logger.e(e);
    }
  }

  void setParent(Parent? val) {
    state.parent = val;
    update();
  }

}