import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.error,
    required this.message,
    required this.query,
    required this.eleves,
  });

  bool error;
  String message;
  String query;
  List<Eleve> eleves;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    error: json["error"] ?? false,
    message: json["message"] ?? '',
    query: json["query"] ?? '',
    eleves: json["Eleves"] != null ? List<Eleve>.from(json["Eleves"].map((x) => Eleve.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "query": query,
    "Eleves": List<dynamic>.from(eleves.map((x) => x.toJson())),
  };
}

class Eleve {
  Eleve({
    required this.nom,
  });

  String nom;

  factory Eleve.fromJson(Map<String, dynamic> json) => Eleve(
    nom: json["nom"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "nom": nom,
  };
}
