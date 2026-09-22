import 'package:myinoface/features/demande_recuperation/data/database/demande_recuperation_local_data_source.dart';
import 'package:myinoface/features/demande_recuperation/data/database/demande_recuperation_remote_data_source.dart';
import 'package:myinoface/features/demande_recuperation/domain/repositories/demande_recuperation_repository.dart';
import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';



class DemandeRecuperationRepositoryImpl implements DemandeRecuperationRepository {

  final DemandeRecuperationRemoteDataSource remoteDataSource;
  final DemandeRecuperationLocalDataSource localDataSource;

  DemandeRecuperationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


  @override
  Future<Either<Failure, DemandeRecuperationModel>> getDemandeRecuperation(int idClass) async {
    try {
      final model = await remoteDataSource.getDemandeRecuperation(idClass);
      if (!model.erreur) {
        await localDataSource.cacheDemandeRecuperation(model);
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