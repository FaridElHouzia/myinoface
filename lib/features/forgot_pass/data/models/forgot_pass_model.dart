import '../../domain/entities/forgot_pass_entity.dart';
import 'package:get/get.dart';



class ForgotPassModel extends ForgotPassEntity {

  const ForgotPassModel({error, message}) : super(erreur: error, message: message);

  factory ForgotPassModel.fromJson(Map<String, dynamic> json) {
    return ForgotPassModel(
      error: json['error'] ?? true,
      message: json['message'] ?? 'error_server'.tr,
    );
  }
}