import '../repositories/forgot_pass_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/forgot_pass_entity.dart';
import 'package:dartz/dartz.dart';
import 'input_forgot_pass.dart';


class GetForgotPass implements UseCase<ForgotPassEntity, InputForgotPass> {

  final ForgotPassRepository repository;
  GetForgotPass({required this.repository});

  @override
  Future<Either<Failure, ForgotPassEntity>> call(InputForgotPass params) async {
    return await repository.getResetPass(params);
  }
}