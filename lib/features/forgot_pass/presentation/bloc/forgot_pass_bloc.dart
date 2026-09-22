import '../../domain/entities/forgot_pass_entity.dart';
import '../../domain/usecases/input_forgot_pass.dart';
import '../../domain/usecases/get_forgot_pass.dart';
import '../../../../core/usecases/constants.dart';
import '../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'forgot_pass_event.dart';

part 'forgot_pass_state.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {

  final GetForgotPass getForgotPass;
  ForgotPassBloc({required this.getForgotPass}) : super(const InitialForgotPassState()) {
    on<ForgotPassEvent>((event, emit) async {
      if (event is ForgotPass) {
        try {
          emit(const LoadingForgotPassState());
          Either<Failure, ForgotPassEntity> either = await getForgotPass.call(event.input);
          either.fold((failure) async {
            final messageFailure = either.fold((failure) => failure.props.elementAt(0) as String? ?? '', (_) => '');
            logger.e('messageFailure: $messageFailure');
            emit(ErrorForgotPassState(message: messageFailure));
          }, (values) async {
            logger.d('values: $values');
            emit(LoadedForgotPassState(entity: values));
          });
        } catch(e) {
          emit(ErrorForgotPassState(message: e.toString()));
        }
      }
    });
  }
}
