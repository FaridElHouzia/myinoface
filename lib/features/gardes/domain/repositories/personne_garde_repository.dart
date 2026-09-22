import 'package:myinoface/features/gardes/data/models/personne_gardes_model.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';


abstract class PersonneGardeRepository {
  Future<Either<Failure, PersonneGardesModel>> getPersonneGarde(DateTime idClass);
}