// To parse this JSON data, do
//
//     final allGardesModel = allGardesModelFromJson(jsonString);

import 'dart:convert';

AllGardesModel allGardesModelFromJson(String str) => AllGardesModel.fromJson(json.decode(str));

String allGardesModelToJson(AllGardesModel data) => json.encode(data.toJson());

class AllGardesModel {
  AllGardesModel({
    this.erreur,
    this.message,
    this.dates,
  });

  bool? erreur;
  String? message;
  List<Date>? dates;

  factory AllGardesModel.fromJson(Map<String, dynamic> json) => AllGardesModel(
    erreur: json["erreur"],
    message: json["message"],
    dates: json["Dates"] != null ? List<Date>.from(json["Dates"].map((x) => Date.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "erreur": erreur,
    "message": message,
    "Dates": dates != null ? List<dynamic>.from(dates!.map((x) => x.toJson())) : null,
  };
}

class Date {
  Date({
    this.dateGarde,
  });

  DateTime? dateGarde;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    dateGarde: json["date_garde"] != null ? DateTime.parse(json["date_garde"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "date_garde": dateGarde != null ? "${dateGarde!.year.toString().padLeft(4, '0')}-${dateGarde!.month.toString().padLeft(2, '0')}-${dateGarde!.day.toString().padLeft(2, '0')}" : null,
  };
}
