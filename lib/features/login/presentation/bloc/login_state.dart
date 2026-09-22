part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  const InitialLoginState();

  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {
  const LoadingLoginState();
  @override
  List<Object> get props => [];
}

class LoadedLoginState extends LoginState {
  final LoginModel model;
  const LoadedLoginState({required this.model});

  @override
  List<Object> get props => [model];
}

class ErrorLoginState extends LoginState {
  final String message;
  const ErrorLoginState({required this.message});

  @override
  List<Object> get props => [message];
}