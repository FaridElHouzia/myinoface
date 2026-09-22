import 'package:myinoface/features/all_classes/data/database/classes_remote_data_source.dart';
import 'package:myinoface/features/all_classes/data/database/classes_local_data_source.dart';
import 'package:myinoface/features/all_classes/domain/repositories/classes_repository.dart';
import 'package:myinoface/features/all_classes/data/models/eleve_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';



class ClassesRepositoryImpl implements ClassesRepository {

  final ClassesRemoteDataSource remoteDataSource;
  final ClassesLocalDataSource localDataSource;

  ClassesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


  @override
  Future<Either<Failure, EleveModel>> getAllClasses(int idClass) async {
    try {
      final model = await remoteDataSource.getAllClasses(idClass);
      if (!model.erreur) {
        await localDataSource.cacheEleveModel(model);
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