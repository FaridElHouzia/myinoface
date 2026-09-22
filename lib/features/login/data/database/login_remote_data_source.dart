import 'dart:convert';

import 'package:myinoface/features/login/data/database/login_local_data_source.dart';
import 'package:myinoface/features/login/domain/usecases/input_qrcode_model.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/data/models/qrcode_model.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:myinoface/core/util/keys.dart';
import 'package:get/get.dart';



abstract class LoginRemoteDataSource {

  Future<LoginModel> getConcreteLogin(InputLoginModel login);
  Future<LoginModel> getConcreteQrCode(InputQrcodeModel login);

}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {

  // final http.Client client;
  final LoginLocalDataSource localDataSource;
  final SharedPreferences preferences;

  LoginRemoteDataSourceImpl({
    // required this.client,
    required this.localDataSource,
    required this.preferences,
  });

  HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);


  @override
  Future<LoginModel> getConcreteLogin(InputLoginModel login) async {
    try {

      logger.i("getConcreteLogin: ${UrlService.getUrl(UrlService.login)}");
      final response = await http.post(
          Uri.parse(UrlService.getUrl(UrlService.login)), body: {
          'inoface_ws': login.toString(),
        }
      );
      LoginModel model = loginModelFromJson(response.body);
      return model.copyWith(motdepasse: login.motdepasse);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<LoginModel> getConcreteQrCode(InputQrcodeModel login) async {
    try {
      final responseUrl = await http.post(
        Uri.parse(UrlService.getUrlFromQrcode),
        body: {
          'inoface_ws': login.toString(),
        }
      );

      // logger.d('body', responseUrl.body);

      QrcodeModel qrcodeModel = qrcodeModelFromJson(responseUrl.body);
      if (qrcodeModel.erreur == false) {
        await preferences.setString(Keys.codeSchool, qrcodeModel.ecolecode);
        logger.i("getConcreteLoginQrCode: ${login.toString()}");
        final response = await http.post(
            Uri.parse(UrlService.getUrl(UrlService.loginWithQrcode)),
            body: {
              'inoface_ws': login.toString(),
            }
        );
        logger.i("getConcreteLoginQrCode: ${response.body}");
        return loginModelFromJson(response.body);
      }
      throw ServerFailure(message: 'error_qrcode'.tr);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}