import 'package:myinoface/features/login/data/database/login_remote_data_source.dart';
import 'package:myinoface/features/login/data/database/login_local_data_source.dart';
import 'package:myinoface/features/login/domain/repositories/login_repository.dart';
import 'package:myinoface/features/login/domain/usecases/input_qrcode_model.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/usecases/constants.dart';



class LoginRepositoryImpl implements LoginRepository {

  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


  @override
  Future<Either<Failure, LoginModel>> getAuthLogin(InputLoginModel login) async {
    try {
      LoginModel model = await remoteDataSource.getConcreteLogin(login);
      if (model.erreur == false) {
        logger.i('getAuthLogin : ${model.personne?.identifiant}');
        await localDataSource.cacheLoginInput(login);
      }
      networkState.isConnected = true;
      return Right(model);
    } on ServerException {
      return Left(ServerFailure(message: 'error_server'.tr));
    } catch (e) {
      logger.e(e);
      if (isOfflineError(e)) {
        networkState.isConnected = false;
        return Left(NetworkFailure(message: "error_connection".tr));
      }
      return Left(ServerFailure(message: 'error_server'.tr));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> getAuthQrCode(InputQrcodeModel login) async {
    try {
      LoginModel model = await remoteDataSource.getConcreteQrCode(login);
      if (model.erreur == false) {
        await localDataSource.cacheLoginInput(InputLoginModel(
          identifiant: model.personne?.identifiant ?? '',
          motdepasse: model.motdepasse ?? '',
          tokenmobile: login.tokenmobile,
        ));
      }
      networkState.isConnected = true;
      return Right(model);
    } on ServerException {
      return Left(ServerFailure(message: 'error_server'.tr));
    } catch (e) {
      logger.e(e);
      if (isOfflineError(e)) {
        networkState.isConnected = false;
        return Left(NetworkFailure(message: "error_connection".tr));
      }
      return Left(ServerFailure(message: 'error_server'.tr));
    }
  }
}