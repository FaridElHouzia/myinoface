import 'package:myinoface/features/login/domain/usecases/input_qrcode_model.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';


abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> getAuthLogin(InputLoginModel login);
  Future<Either<Failure, LoginModel>> getAuthQrCode(InputQrcodeModel login);
}