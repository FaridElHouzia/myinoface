import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/features/login/data/database/login_local_data_source.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';



abstract class DemandeRecuperationRemoteDataSource {

  Future<DemandeRecuperationModel> getDemandeRecuperation(int idClass);
}

class DemandeRecuperationRemoteDataSourceImpl implements DemandeRecuperationRemoteDataSource {

  final http.Client client;
  final LoginLocalDataSource localDataSource;
  final SharedPreferences preferences;

  DemandeRecuperationRemoteDataSourceImpl({
    required this.client,
    required this.localDataSource,
    required this.preferences,
  });

  @override
  Future<DemandeRecuperationModel> getDemandeRecuperation(int idClass) async {
    try {
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
        'id_classe': idClass,
      };
      http.Response response = await client.post(
        Uri.parse(UrlService.getUrl(UrlService.getDemandesRecuperationsByIdClasse)),
        body: {'inoface_ws': json.encode(body)}
      );

      logger.i("getDemandeRecuperation: class=$idClass status=${response.statusCode}");
      try {
        return demandeRecuperationModelFromJson(response.body);
      } catch (e) {
        logger.e('getDemandeRecuperation parse failed: $e body=${response.body}');
        rethrow;
      }
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}