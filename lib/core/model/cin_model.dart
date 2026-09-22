import 'dart:convert';

import 'package:myinoface/core/util/url_service.dart';

CinModel cinModelFromJson(String str) => CinModel.fromJson(json.decode(str));

String cinModelToJson(CinModel data) => json.encode(data.toJson());

class CinModel {
  CinModel({
    this.error,
    this.message,
    this.idParent,
    this.cin,
  });

  bool? error;
  String? message;
  int? idParent;
  Cin? cin;

  factory CinModel.fromJson(Map<String, dynamic> json) => CinModel(
    error: json["error"],
    message: json["message"],
    idParent: json["id_parent"],
    cin: json["Cin"] != null ? Cin.fromJson(json["Cin"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "id_parent": idParent,
    "Cin": cin?.toJson(),
  };
}

class Cin {
  Cin({
    this.cinRecto,
    this.cinVerso,
    this.idParent,
  });

  String? cinRecto;
  String? cinVerso;
  int? idParent;

  factory Cin.fromJson(Map<String, dynamic> json) => Cin(
    cinRecto: UrlService.rewriteInoserUriOrNull(json["cin_recto"]?.toString()),
    cinVerso: UrlService.rewriteInoserUriOrNull(json["cin_verso"]?.toString()),
    idParent: json["id_parent"],
  );

  Map<String, dynamic> toJson() => {
    "cin_recto": cinRecto,
    "cin_verso": cinVerso,
    "id_parent": idParent,
  };
}
