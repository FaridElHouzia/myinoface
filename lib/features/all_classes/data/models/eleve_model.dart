import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'dart:convert';

EleveModel eleveModelFromJson(String str) => EleveModel.fromJson(json.decode(str));

String eleveModelToJson(EleveModel data) => json.encode(data.toJson());

class EleveModel {
  EleveModel({
    required this.erreur,
    required this.id_classe,
    required this.classe_description,
    required this.eleves,
  });

  bool erreur;
  int id_classe;
  String classe_description;
  List<Eleve> eleves;

  factory EleveModel.fromJson(Map<String, dynamic> json) => EleveModel(
    erreur: json["erreur"] ?? false,
    id_classe: json["id_classe"] ?? 0,
    classe_description: json["classe_description"] ?? '',
    eleves: (json["Eleves"] != null) ? List<Eleve>.from(json["Eleves"].map((x) => Eleve.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "erreur": erreur,
    "id_classe": id_classe,
    "classe_description": classe_description,
    "Eleves": List<dynamic>.from(eleves.map((x) => x.toJson())),
  };
}

class Eleve extends EleveEntitie {

  Eleve({
    required this.idPersonne,
    required this.nom,
    required this.prenom,
    required this.eleveNom,
    this.elevePhoto,
    required this.idClasse,
    this.idEleveRecuperations,
  }) : super(
    id_personne: idPersonne,
    nom: nom,
    prenom: prenom,
    eleve_nom: eleveNom,
    eleve_photo: elevePhoto,
    id_classe: idClasse,
    id_eleve_recuperations: idEleveRecuperations,
  );

  int idPersonne;
  String nom;
  String prenom;
  String eleveNom;
  String? elevePhoto;
  int idClasse;
  int? idEleveRecuperations;


  factory Eleve.fromJson(Map<String, dynamic> json) => Eleve(
    idPersonne: json["id_personne"] ?? 0,
    nom: json["nom"] ?? '',
    prenom: json["prenom"] ?? '',
    eleveNom: json["eleve_nom"] ?? '',
    elevePhoto: UrlService.rewriteInoserUriOrNull(json["eleve_photo"]?.toString()),
    idClasse: json["id_classe"] ?? 0,
    idEleveRecuperations: json["id_eleve_recuperations"],
  );

  Map<String, dynamic> toJsonModle() => {
    "id_personne": idPersonne,
    "nom": nom,
    "prenom": prenom,
    "eleve_nom": eleveNom,
    "eleve_photo": elevePhoto,
    "id_classe": idClasse,
    "id_eleve_recuperations": idEleveRecuperations,
  };
}
