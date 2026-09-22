import 'dart:convert';

ParentInfoModel parentInfoModelFromJson(String str) => ParentInfoModel.fromJson(json.decode(str));

String parentInfoModelToJson(ParentInfoModel data) => json.encode(data.toJson());

class ParentInfoModel {
  ParentInfoModel({
    required this.error,
    required this.message,
    required this.idPersonne,
    required this.parents,
  });

  bool error;
  String message;
  int idPersonne;
  List<Parent> parents;

  factory ParentInfoModel.fromJson(Map<String, dynamic> json) => ParentInfoModel(
    error: json["error"],
    message: json["message"],
    idPersonne: json["id_personne"],
    parents: json["Parents"] != null ? List<Parent>.from(json["Parents"].map((x) => Parent.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "id_personne": idPersonne,
    "Parents": List<dynamic>.from(parents.map((x) => x.toJson())),
  };
}

class Parent {
  Parent({
    required this.idParent,
    required this.nom,
    required this.prenom,
    required this.lien,
    required this.idPersonne,
  });

  int idParent;
  String nom;
  String prenom;
  String lien;
  int idPersonne;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    idParent: json["id_parent"],
    nom: json["nom"],
    prenom: json["prenom"],
    lien: json["lien"],
    idPersonne: json["id_personne"],
  );

  Map<String, dynamic> toJson() => {
    "id_parent": idParent,
    "nom": nom,
    "prenom": prenom,
    "lien": lien,
    "id_personne": idPersonne,
  };
}
