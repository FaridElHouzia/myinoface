import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/util/keys.dart';
import 'package:logger/logger.dart';
import 'dart:async' show Future;
import 'dart:convert';



class PreferenceUtils {

  static SharedPreferences? _prefsInstance;
  static PreferenceUtils? _preferenceUtils;
  static var logger = Logger();

  // call this method from iniState() function of mainApp().
  static Future<PreferenceUtils> init() async {
    _prefsInstance ??= await SharedPreferences.getInstance();
    _preferenceUtils ??= PreferenceUtils();
    return _preferenceUtils!;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static bool containsKey(String key, [bool? defValue]) {
    return _prefsInstance!.containsKey(key);
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefsInstance!.setString(key, value);
  }

  static Future<bool> removeKey(String key, [bool defValue = false]) async {
    return await _prefsInstance!.remove(key);
  }

  static List<String> getKeys() {
    return _prefsInstance?.getKeys().toList() ?? [];
  }

  static InputLoginModel? getInputLogin() {
    // try {
      final String? loginJson = _prefsInstance?.getString(Keys.cachedLoginInput);
      if (loginJson != null) {
        final login = InputLoginModel.fromJson(json.decode(loginJson));
        logger.i('cached login: ${login.identifiant}');
        return login;
      } else {
        return null;
      }
    // } catch(e) {
    //   logger.e(e);
    //   _prefsInstance?.remove(Keys.cachedLoginInput);
    //   return null;
    // }
  }


  // static PreferenceUtils _instance;
  // static SharedPreferences _preferences;
  // static Future<PreferenceUtils> getInstance() async {
  //   if (_instance == null) {
  //     _instance = PreferenceUtils();
  //   }
  //   if (_preferences == null) {
  //     _preferences = await SharedPreferences.getInstance();
  //   }
  //   return _instance;
  // }
}