import 'dart:convert';

PersonneGardesModel personneGardesModelFromJson(String str) => PersonneGardesModel.fromJson(json.decode(str));

String personneGardesModelToJson(PersonneGardesModel data) => json.encode(data.toJson());

class PersonneGardesModel {
  PersonneGardesModel({
    required this.erreur,
    required this.message,
    required this.gardes,
  });

  bool erreur;
  String message;
  List<Garde> gardes;

  factory PersonneGardesModel.fromJson(Map<String, dynamic> json) => PersonneGardesModel(
    erreur: json["erreur"],
    message: json["message"],
    gardes: List<Garde>.from(json["Gardes"].map((x) => Garde.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "erreur": erreur,
    "message": message,
    "Gardes": List<dynamic>.from(gardes.map((x) => x.toJson())),
  };
}

class Garde {
  Garde({
    required this.idGardes,
    required this.gardeDescription,
    required this.minHeure,
    required this.maxHeure,
    required this.dateGarde,
    required this.idPersonne,
  });

  int idGardes;
  String gardeDescription;
  String minHeure;
  String maxHeure;
  DateTime dateGarde;
  int idPersonne;

  factory Garde.fromJson(Map<String, dynamic> json) => Garde(
    idGardes: json["id_gardes"],
    gardeDescription: json["garde_description"],
    minHeure: json["min_heure"],
    maxHeure: json["max_heure"],
    dateGarde: DateTime.parse(json["date_garde"]),
    idPersonne: json["id_personne"],
  );

  Map<String, dynamic> toJson() => {
    "id_gardes": idGardes,
    "garde_description": gardeDescription,
    "min_heure": minHeure,
    "max_heure": maxHeure,
    "date_garde": "${dateGarde.year.toString().padLeft(4, '0')}-${dateGarde.month.toString().padLeft(2, '0')}-${dateGarde.day.toString().padLeft(2, '0')}",
    "id_personne": idPersonne,
  };
}
