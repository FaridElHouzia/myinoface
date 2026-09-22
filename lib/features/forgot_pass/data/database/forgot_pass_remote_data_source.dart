import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/forgot_pass_entity.dart';
import '../../domain/usecases/input_forgot_pass.dart';
import '../../../../core/util/url_service.dart';
import '../../../../core/error/failures.dart';
import '../models/forgot_pass_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:convert';


abstract class ForgotPassRemoteDataSource {
  Future<ForgotPassEntity> resetPass(InputForgotPass input);
}

class ForgotPassRemoteDataSourceImpl implements ForgotPassRemoteDataSource {

  final http.Client client;
  final SharedPreferences preferences;
  ForgotPassRemoteDataSourceImpl({required this.client, required this.preferences});


  @override
  Future<ForgotPassEntity> resetPass(InputForgotPass input) async {
    try {

      log("resetPass: ${input.toJson()}");
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.FORGIT_PASSWORD)), body: {
          "inoface_ws" : input.toString(),
        }
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> collection = await json.decode(response.body);
        log("collection: $collection");
        return ForgotPassModel.fromJson(collection);
      } else {
        throw ServerFailure(message: 'error_server'.tr);
      }
    } catch (e) {
      rethrow;
    }
  }
}