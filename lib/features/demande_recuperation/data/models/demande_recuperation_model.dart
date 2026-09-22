import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'dart:convert';

DemandeRecuperationModel demandeRecuperationModelFromJson(String str) => DemandeRecuperationModel.fromJson(json.decode(str));
String demandeRecuperationModelToJson(DemandeRecuperationModel data) => json.encode(data.toJson());

String _asString(dynamic value) => value?.toString() ?? '';

int _asInt(dynamic value, [int fallback = 0]) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

class DemandeRecuperationModel {
  DemandeRecuperationModel({
    required this.erreur,
    required this.message,
    required this.Titre,
    this.timeCounter = 30,
    required this.demandesRecuperations,
  });

  final bool erreur;
  final String message;
  final String Titre;
  final int timeCounter;
  final List<DemandesRecuperationMod> demandesRecuperations;

  factory DemandeRecuperationModel.fromJson(Map<String, dynamic> json) => DemandeRecuperationModel(
    erreur: json["erreur"] == true,
    message: _asString(json["message"]),
    Titre: _asString(json["Titre"]),
    timeCounter: _asInt(json["timeCounter"], 30),
    demandesRecuperations: json["DemandesRecuperations"] == null
        ? <DemandesRecuperationMod>[]
        : List<DemandesRecuperationMod>.from(
            (json["DemandesRecuperations"] as List)
                .map((x) => DemandesRecuperationMod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "erreur": erreur,
    "message": message,
    "Titre": Titre,
    "DemandesRecuperations": List<dynamic>.from(demandesRecuperations.map((x) => x.toJsonMode())),
  };
}

class DemandesRecuperationMod extends DemandesRecuperation {
  DemandesRecuperationMod({
    required this.idEleveRecuperations,
    required this.idClasse,
    required this.parentNom,
    required this.eleveNom,
    required this.elevePhoto,
    required this.dateDeLaDemande,
  }) : super(
    id_eleve_recuperations: idEleveRecuperations,
    id_classe: idClasse,
    parent_nom: parentNom,
    eleve_nom: eleveNom,
    eleve_photo: elevePhoto,
    date_de_la_demande: dateDeLaDemande
  );

  final int idEleveRecuperations;
  final int idClasse;
  final String parentNom;
  final String eleveNom;
  final String elevePhoto;
  final DateTime dateDeLaDemande;

  factory DemandesRecuperationMod.fromJson(Map<String, dynamic> json) => DemandesRecuperationMod(
    idEleveRecuperations: _asInt(json["id_eleve_recuperations"]),
    idClasse: _asInt(json["id_classe"]),
    parentNom: _asString(json["parent_nom"]),
    eleveNom: _asString(json["eleve_nom"]),
    elevePhoto: UrlService.rewriteInoserUri(_asString(json["eleve_photo"])),
    dateDeLaDemande: DateTime.tryParse(_asString(json["date_de_la_demande"])) ?? DateTime.now(),
  );

  Map<String, dynamic> toJsonMode() => {
    "id_eleve_recuperations": idEleveRecuperations,
    "id_classe": idClasse,
    "parent_nom": parentNom,
    "eleve_nom": eleveNom,
    "eleve_photo": elevePhoto,
    "date_de_la_demande": dateDeLaDemande.toIso8601String(),
  };
}
