import 'package:myinoface/features/gardes/data/database/personne_garde_local_data_source.dart';
import 'package:myinoface/features/gardes/data/database/personne_garde_remote_data_source.dart';
import 'package:myinoface/features/gardes/domain/repositories/personne_garde_repository.dart';
import 'package:myinoface/features/gardes/data/models/personne_gardes_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';



class PersonneGardeRepositoryImpl implements PersonneGardeRepository {

  final PersonneGardeRemoteDataSource remoteDataSource;
  final PersonneGardeLocalDataSource localDataSource;

  PersonneGardeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


  @override
  Future<Either<Failure, PersonneGardesModel>> getPersonneGarde(DateTime date) async {
    try {
      final model = await remoteDataSource.getPersonneGarde(date);
      if (!model.erreur) {
        await localDataSource.cachePersonneGardeModel(model);
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