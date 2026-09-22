// To parse this JSON data, do
//
//     final responseLoginModel = responseLoginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

String _asString(dynamic value) => value?.toString() ?? '';

int _asInt(dynamic value, [int fallback = 0]) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

class LoginModel {
  LoginModel({
    required this.erreur,
    required this.message,
    required this.ecolename,
    required this.recuperationEnfantOption,
    this.personne,
    this.motdepasse,
  });

  final bool erreur;
  final String message;
  final String ecolename;
  final String? motdepasse;
  final bool recuperationEnfantOption;
  final Personne? personne;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    erreur: json["erreur"] == true,
    message: _asString(json["message"]),
    ecolename: _asString(json["ecolename"]),
    motdepasse: json["motdepasse"]?.toString(),
    recuperationEnfantOption: json["recuperation_enfant_option"] == true,
    personne: json["Personne"] is Map<String, dynamic>
        ? Personne.fromJson(json["Personne"])
        : null,
  );

  LoginModel copyWith({
    bool? erreur,
    String? message,
    String? ecolename,
    String? motdepasse,
    bool? recuperationEnfantOption,
    Personne? personne,
  }) => LoginModel(
    erreur: erreur ?? this.erreur,
    message: message ?? this.message,
    ecolename: ecolename ?? this.ecolename,
    motdepasse: motdepasse ?? this.motdepasse,
    recuperationEnfantOption: recuperationEnfantOption ?? this.recuperationEnfantOption,
    personne: personne ?? this.personne,
  );

  Map<String, dynamic> toJson() => {
    "erreur": erreur,
    "message": message,
    "ecolename": ecolename,
    "motdepasse": motdepasse,
    "recuperation_enfant_option": recuperationEnfantOption,
    "Personne": personne?.toJson(),
  };
}

class Personne {
  Personne({
    required this.idPersonne,
    required this.nom,
    required this.prenom,
    required this.nomArabe,
    required this.prenomArabe,
    required this.identifiant,
    this.cin,
    this.gsm,
    required this.email,
    required this.genre,
    required this.token,
    required this.roles,
  });

  int idPersonne;
  String nom;
  String prenom;
  String nomArabe;
  String prenomArabe;
  String identifiant;
  dynamic cin;
  String? gsm;
  String email;
  String genre;
  String token;
  List<Role> roles;

  factory Personne.fromJson(Map<String, dynamic> json) => Personne(
    idPersonne: _asInt(json["id_personne"]),
    nom: _asString(json["nom"]),
    prenom: _asString(json["prenom"]),
    nomArabe: _asString(json["nom_arabe"]),
    prenomArabe: _asString(json["prenom_arabe"]),
    identifiant: _asString(json["identifiant"]),
    cin: json["cin"],
    gsm: json["gsm"]?.toString(),
    email: _asString(json["email"]),
    genre: _asString(json["genre"]),
    token: _asString(json["token"]),
    roles: json["Roles"] == null
        ? <Role>[]
        : List<Role>.from((json["Roles"] as List).map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_personne": idPersonne,
    "nom": nom,
    "prenom": prenom,
    "nom_arabe": nomArabe,
    "prenom_arabe": prenomArabe,
    "identifiant": identifiant,
    "cin": cin,
    "gsm": gsm,
    "email": email,
    "genre": genre,
    "token": token,
    "Roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    required this.idRole,
    required this.roleDescription,
    required this.defaultRole,
    required this.idPersonne,
  });

  int idRole;
  String roleDescription;
  int defaultRole;
  int idPersonne;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    idRole: _asInt(json["id_role"]),
    roleDescription: _asString(json["role_description"]),
    defaultRole: _asInt(json["default_role"]),
    idPersonne: _asInt(json["id_personne"]),
  );

  Map<String, dynamic> toJson() => {
    "id_role": idRole,
    "role_description": roleDescription,
    "default_role": defaultRole,
    "id_personne": idPersonne,
  };
}
