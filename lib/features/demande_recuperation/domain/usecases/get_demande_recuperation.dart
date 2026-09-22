import 'package:myinoface/features/demande_recuperation/domain/repositories/demande_recuperation_repository.dart';
import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/core/usecases/usecase.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';


class GetDemandeRecuperation implements UseCase<DemandeRecuperationModel, int> {

  final DemandeRecuperationRepository repository;
  GetDemandeRecuperation({required this.repository});

  @override
  Future<Either<Failure, DemandeRecuperationModel>> call(int params) async {
    return await repository.getDemandeRecuperation(params);
  }
}