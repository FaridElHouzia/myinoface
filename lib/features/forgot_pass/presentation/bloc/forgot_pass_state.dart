part of 'forgot_pass_bloc.dart';

@immutable
abstract class ForgotPassState extends Equatable {
  const ForgotPassState();
}

class InitialForgotPassState extends ForgotPassState {
  const InitialForgotPassState();
  @override
  List<Object> get props => [];
}

class LoadingForgotPassState extends ForgotPassState {
  const LoadingForgotPassState();
  @override
  List<Object> get props => [];
}

class LoadedForgotPassState extends ForgotPassState {
  final ForgotPassEntity entity;
  const LoadedForgotPassState({required this.entity});
  @override
  List<Object> get props => [entity];
}

class ErrorForgotPassState extends ForgotPassState {
  final String message;
  const ErrorForgotPassState({required this.message});
  @override
  List<Object> get props => [message];
}
