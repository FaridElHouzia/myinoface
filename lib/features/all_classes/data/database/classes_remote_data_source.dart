import 'package:myinoface/features/login/data/database/login_local_data_source.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/all_classes/data/models/eleve_model.dart';
import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'dart:convert';



abstract class ClassesRemoteDataSource {
  Future<EleveModel> getAllClasses(int idClass);
}

class ClassesRemoteDataSourceImpl implements ClassesRemoteDataSource {

  final LoginLocalDataSource localDataSource;
  final SharedPreferences preferences;
  final http.Client client;

  ClassesRemoteDataSourceImpl({
    required this.localDataSource,
    required this.preferences,
    required this.client,
  });


  @override
  Future<EleveModel> getAllClasses(int idClass) async {
    try {
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant?.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse?.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile?.replaceAll(' ', ''),
        'id_classe': idClass,
      };

      http.Response response = await client.post(
        Uri.parse(UrlService.getUrl(UrlService.GetElevesByIdClasse_ws)),
        body: {'inoface_ws': json.encode(body)}
      );

      logger.i("getElevesByIdClasse: class=$idClass status=${response.statusCode}");
      return eleveModelFromJson(response.body);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}