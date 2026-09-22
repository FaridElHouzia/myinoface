import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';


abstract class DemandeRecuperationRepository {
  Future<Either<Failure, DemandeRecuperationModel>> getDemandeRecuperation(int idClass);
}