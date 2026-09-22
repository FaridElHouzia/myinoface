import '../../../../core/usecases/constants.dart';
import '../../domain/entities/forgot_pass_entity.dart';
import '../../domain/repositories/forgot_pass_repository.dart';
import '../../domain/usecases/input_forgot_pass.dart';
import '../database/forgot_pass_remote_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';


class ForgotPassRepositoryImpl implements ForgotPassRepository {

  final ForgotPassRemoteDataSource remoteDataSource;

  final logger = Logger();

  ForgotPassRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ForgotPassEntity>> getResetPass(InputForgotPass inputLogin) async {
    try {
      return Right(await remoteDataSource.resetPass(inputLogin));
    } on ServerException {
      return Left(ServerFailure(message: 'error_server'.tr));
    } catch (e) {
      logger.e(e);
      if (isOfflineError(e)) {
        return Left(ServerFailure(message: "error_connection".tr));
      }
      return Left(ServerFailure(message: 'error_server'.tr));
    }
  }
}