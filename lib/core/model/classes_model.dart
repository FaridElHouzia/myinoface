import 'package:myinoface/core/database/app_database.dart';
import 'dart:convert';


ClassesModel classesModelFromJson(String str) => ClassesModel.fromJson(json.decode(str));
String classesModelToJson(ClassesModel data) => json.encode(data.toJson());


class ClassesModel {
  ClassesModel({
    this.erreur = true,
    this.message = '',
    this.acces_recuperation = false,
    this.classes,
  });

  bool erreur;
  String message;
  bool acces_recuperation;
  List<Class>? classes;

  factory ClassesModel.fromJson(Map<String, dynamic> json) => ClassesModel(
    erreur: json["erreur"]??true,
    message: json["message"]??'',
    acces_recuperation: json["acces_recuperation"]??false,
    classes: json["Classes"] != null ? List<Class>.from(json["Classes"].map((x) => Class.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "erreur": erreur,
    "message": message,
    "acces_recuperation": acces_recuperation,
    "Classes": classes != null ? List<dynamic>.from(classes!.map((x) => x.toJsonModel())) : null,
  };
}

class Class extends ClassEntitie {
  Class({
    required int idClasse,
    required String classeDescription,
    required int idNiveau,
    required String niveau,
    required int nbrnotification,
    String? Responsable,
  }) : super(
    id_classe: idClasse,
    classe_description: classeDescription,
    id_niveau: idNiveau,
    niveau: niveau,
    nbrnotification: nbrnotification,
    Responsable: Responsable,
  );

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    idClasse: json["id_classe"]??0,
    classeDescription: json["classe_description"]??'',
    idNiveau: json["id_niveau"]??0,
    niveau: json["niveau"]??'',
    nbrnotification: json["nbrnotification"]??0,
    Responsable: json["Responsable"],
  );

  Map<String, dynamic> toJsonModel() => {
    "id_classe": id_classe,
    "classe_description": classe_description,
    "id_niveau": id_niveau,
    "niveau": niveau,
    "nbrnotification": nbrnotification,
    "Responsable": Responsable,
  };
}
