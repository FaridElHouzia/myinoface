import 'package:intl/intl.dart';
import 'package:myinoface/features/gardes/data/models/personne_gardes_model.dart';
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



abstract class PersonneGardeRemoteDataSource {

  Future<PersonneGardesModel> getPersonneGarde(DateTime date);
}

class PersonneGardeRemoteDataSourceImpl implements PersonneGardeRemoteDataSource {

  final http.Client client;
  final LoginLocalDataSource localDataSource;
  final SharedPreferences preferences;

  PersonneGardeRemoteDataSourceImpl({
    required this.client,
    required this.localDataSource,
    required this.preferences,
  });


  @override
  Future<PersonneGardesModel> getPersonneGarde(DateTime date) async {
    try {
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      var body = {
        'identifiant': login?.identifiant?.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse?.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile?.replaceAll(' ', ''),
        'date_garde': formattedDate,
      };
      http.Response response = await client.post(
        Uri.parse(UrlService.getUrl(UrlService.GetPersonneGardeByDate_ws)),
        body: {'inoface_ws': json.encode(body)}
      );
      logger.i("getPersonneGarde: date=$formattedDate status=${response.statusCode}");
      return personneGardesModelFromJson(response.body);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}