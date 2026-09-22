import 'package:myinoface/features/all_classes/domain/repositories/classes_repository.dart';
import 'package:myinoface/features/all_classes/data/models/eleve_model.dart';
import 'package:myinoface/core/usecases/usecase.dart';
import 'package:myinoface/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';


class GetClasses implements UseCase<EleveModel, int> {

  final ClassesRepository repository;
  GetClasses({required this.repository});

  @override
  Future<Either<Failure, EleveModel>> call(int params) async {
    return await repository.getAllClasses(params);
  }
}