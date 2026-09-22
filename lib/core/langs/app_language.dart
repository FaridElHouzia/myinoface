import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:myinoface/core/util/keys.dart';
import 'package:get/get.dart';


class AppLanguage extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  void saveLanguage(String lang) async {
    await PreferenceUtils.setString(Keys.local, lang);
    update();
  }
}