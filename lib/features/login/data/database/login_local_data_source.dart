import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/util/keys.dart';
import 'dart:convert';



abstract class LoginLocalDataSource {
  Future<void> cacheLoginResponse(LoginModel model);
  Future<void> cacheLoginInput(InputLoginModel inputLogin);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {

  final SharedPreferences preferences;
  final AppDatabase db;
  LoginLocalDataSourceImpl({
    required this.preferences,
    required this.db,
  });

  @override
  Future<void> cacheLoginResponse(LoginModel model) async {
    final json = loginModelToJson(model);
    await preferences.setString(Keys.cachedLoginResponse, json);
  }

  @override
  Future<void> cacheLoginInput(InputLoginModel inputLogin) async {
    await preferences.setString(Keys.cachedLoginInput, json.encode(inputLogin.toJson()));
  }
}