import '../../../../core/error/failures.dart';
import '../entities/forgot_pass_entity.dart';
import '../usecases/input_forgot_pass.dart';
import 'package:dartz/dartz.dart';



abstract class ForgotPassRepository {
  Future<Either<Failure, ForgotPassEntity>> getResetPass(InputForgotPass inputLogin);
}