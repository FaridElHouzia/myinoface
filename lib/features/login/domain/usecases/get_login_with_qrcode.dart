import 'package:myinoface/features/login/data/models/qrcode_model.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import 'package:myinoface/features/login/domain/repositories/login_repository.dart';
import 'package:myinoface/features/login/domain/usecases/input_qrcode_model.dart';
import 'package:myinoface/core/usecases/usecase.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';


class GetLoginWithQrcode implements UseCase<LoginModel, InputQrcodeModel> {

  final LoginRepository repository;
  GetLoginWithQrcode({required this.repository});

  @override
  Future<Either<Failure, LoginModel>> call(InputQrcodeModel params) async {
    return await repository.getAuthQrCode(params);
  }
}