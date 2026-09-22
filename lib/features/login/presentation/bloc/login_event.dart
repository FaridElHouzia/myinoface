part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithEmailAndPass extends LoginEvent {
  final InputLoginModel inputLogin;
  const LoginWithEmailAndPass({required this.inputLogin});

  @override
  List<Object> get props => [inputLogin];
}

class LoginWithQRCode extends LoginEvent {
  final InputQrcodeModel inputQrcode;
  const LoginWithQRCode({required this.inputQrcode});

  @override
  List<Object> get props => [inputQrcode];
}