import 'package:myinoface/features/all_classes/data/models/eleve_model.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';


abstract class ClassesRepository {
  Future<Either<Failure, EleveModel>> getAllClasses(int idClass);
}