import 'package:myinoface/features/all_classes/data/models/eleve_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:flutter/material.dart';



abstract class ClassesLocalDataSource {
  Future<void> cacheEleveModel(EleveModel model);
}

class ClassesLocalDataSourceImpl implements ClassesLocalDataSource {

  final SharedPreferences preferences;
  final AppDatabase db;
  ClassesLocalDataSourceImpl({
    required this.preferences,
    required this.db,
  });


  @override
  Future<void> cacheEleveModel(EleveModel model) async {
    try {
      await db.delete(db.eleveEntities).go();
      if (model != null && model.eleves != null) {
        await db.eleveEntitiesDao.insertAllEleveEntities(model.eleves);
      }
    } catch(e) {
      logger.e(e);
      throw const CacheFailure();
    }
  }
}