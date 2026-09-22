// To parse this JSON data, do
//
//     final elevesByQueryModel = elevesByQueryModelFromJson(jsonString);

import 'dart:convert';

import 'eleve_model.dart';

ElevesByQueryModel elevesByQueryModelFromJson(String str) => ElevesByQueryModel.fromJson(json.decode(str));

String elevesByQueryModelToJson(ElevesByQueryModel data) => json.encode(data.toJson());

class ElevesByQueryModel {
  ElevesByQueryModel({
    required this.error,
    required this.message,
    required this.query,
    required this.eleves,
  });

  bool error;
  String message;
  String query;
  List<Eleve> eleves;

  factory ElevesByQueryModel.fromJson(Map<String, dynamic> json) => ElevesByQueryModel(
    error: json["error"],
    message: json["message"],
    query: json["query"],
    eleves: List<Eleve>.from(json["Eleves"].map((x) => Eleve.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "query": query,
    "Eleves": List<dynamic>.from(eleves.map((x) => x.toJson())),
  };
}

/*
class Eleve {
  Eleve({
    this.idPersonne,
    this.nom,
    this.prenom,
    this.eleveNom,
    this.elevePhoto,
    this.idClasse,
    this.classe,
    this.niveau,
    this.idEleveRecuperations,
  });

  int idPersonne;
  String nom;
  String prenom;
  String eleveNom;
  String elevePhoto;
  int idClasse;
  String classe;
  String niveau;
  dynamic idEleveRecuperations;

  factory Eleve.fromJson(Map<String, dynamic> json) => Eleve(
    idPersonne: json["id_personne"],
    nom: json["nom"],
    prenom: json["prenom"],
    eleveNom: json["eleve_nom"],
    elevePhoto: json["eleve_photo"],
    idClasse: json["id_classe"],
    classe: json["classe"],
    niveau: json["niveau"],
    idEleveRecuperations: json["id_eleve_recuperations"],
  );

  Map<String, dynamic> toJson() => {
    "id_personne": idPersonne,
    "nom": nom,
    "prenom": prenom,
    "eleve_nom": eleveNom,
    "eleve_photo": elevePhoto,
    "id_classe": idClasse,
    "classe": classe,
    "niveau": niveau,
    "id_eleve_recuperations": idEleveRecuperations,
  };
}

 */
