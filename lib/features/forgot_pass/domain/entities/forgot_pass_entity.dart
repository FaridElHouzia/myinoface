import 'package:get/get.dart';
import 'package:equatable/equatable.dart';

class ForgotPassEntity extends Equatable {

  final bool erreur;
  final String message;
  const ForgotPassEntity({this.erreur = true, this.message = ''});

  @override
  List<Object> get props => [erreur, message];
}