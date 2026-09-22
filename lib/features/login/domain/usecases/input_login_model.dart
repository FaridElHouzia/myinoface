import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';


class InputLoginModel extends Equatable {

  final String identifiant;
  final String motdepasse;
  final String tokenmobile;

  const InputLoginModel({
    required this.identifiant,
    required this.motdepasse,
    required this.tokenmobile,
  });

  factory InputLoginModel.fromJson(Map<String, dynamic> json) => InputLoginModel(
    identifiant: json["identifiant"],
    motdepasse: json["motdepasse"],
    tokenmobile: json["tokenmobile"],
  );

  @override
  String toString() {
    Map<String, String> body = {
      'identifiant': identifiant.replaceAll(' ', ''),
      'motdepasse': motdepasse.replaceAll(' ', ''),
      'tokenmobile': tokenmobile.replaceAll(' ', ''),
    };
    return json.encode(body);
  }

  Map<String, dynamic> toJson() {
    return {
      'identifiant': identifiant,
      'motdepasse': motdepasse,
      'tokenmobile': tokenmobile,
    };
  }


  @override
  List<Object> get props => [identifiant, motdepasse, tokenmobile];

}