import 'package:myinoface/features/gardes/domain/repositories/personne_garde_repository.dart';
import 'package:myinoface/features/gardes/data/models/personne_gardes_model.dart';
import 'package:myinoface/core/usecases/usecase.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';


class GetPersonneGarde implements UseCase<PersonneGardesModel, DateTime> {

  final PersonneGardeRepository repository;
  GetPersonneGarde({required this.repository});

  @override
  Future<Either<Failure, PersonneGardesModel>> call(DateTime params) async {
    return await repository.getPersonneGarde(params);
  }
}