import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/util/keys.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


abstract class DemandeRecuperationLocalDataSource {
  Future<void> cacheDemandeRecuperation(DemandeRecuperationModel model);
  // Future<void> cacheLoginInput(InputLoginModel inputLogin);
}

class DemandeRecuperationLocalDataSourceImpl implements DemandeRecuperationLocalDataSource {

  final SharedPreferences preferences;
  final AppDatabase db;
  DemandeRecuperationLocalDataSourceImpl({
    required this.preferences,
    required this.db,
  });

  // @override
  // Future<void> cacheLoginResponse(LoginModel model) async {
  //   final json = loginModelToJson(model);
  //   await preferences.setString(Keys.cachedLoginResponse, json);
  // }
  //
  // @override
  // Future<void> cacheLoginInput(InputLoginModel inputLogin) async {
  //   await preferences.setString(Keys.cachedLoginInput, json.encode(inputLogin.toJson()));
  // }

  @override
  Future<void> cacheDemandeRecuperation(DemandeRecuperationModel model) async {
    await db.delete(db.demandesRecuperations).go();
    if (model.demandesRecuperations != null) {
      await db.demandesRecuperationsDao.insertAllDemandesRecuperations(model.demandesRecuperations);
    }
  }
}