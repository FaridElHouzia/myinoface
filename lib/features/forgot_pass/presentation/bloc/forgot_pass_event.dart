part of 'forgot_pass_bloc.dart';

@immutable
abstract class ForgotPassEvent extends Equatable {
  const ForgotPassEvent();
}

class ForgotPass extends ForgotPassEvent {
  final InputForgotPass input;
  const ForgotPass({required this.input});

  @override
  List<Object> get props => [input];
}
