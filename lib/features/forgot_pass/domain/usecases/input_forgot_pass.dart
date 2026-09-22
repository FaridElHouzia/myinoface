import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';


class InputForgotPass extends Equatable {
  final String identifiant;
  final String email;

  InputForgotPass({
    required this.identifiant,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'identifiant': identifiant,
      'email': email,
    };
  }

  String toString() {
    var body = {
      'identifiant': this.identifiant.replaceAll(' ', ''),
      'email': this.email.replaceAll(' ', ''),
    };
    return json.encode(body);
  }

  @override
  // TODO: implement props
  List<Object> get props => [identifiant, email];
}