import 'package:myinoface/features/gardes/data/models/personne_gardes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:flutter/material.dart';



abstract class PersonneGardeLocalDataSource {
  Future<void> cachePersonneGardeModel(PersonneGardesModel model);
}

class PersonneGardeLocalDataSourceImpl implements PersonneGardeLocalDataSource {

  final SharedPreferences preferences;
  final AppDatabase db;
  PersonneGardeLocalDataSourceImpl({
    required this.preferences,
    required this.db,
  });


  @override
  Future<void> cachePersonneGardeModel(PersonneGardesModel model) async {
    try {

      if (model != null && model.gardes != null) {

      }
    } catch(e) {
      logger.e(e);
      throw const CacheFailure();
    }
  }
}