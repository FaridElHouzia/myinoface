import 'package:equatable/equatable.dart';


class NotificationModel extends Equatable {

  final String title;
  final String body;
  final String type;
  final int id;
  final int? idPersonne;


  const NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.id,
    this.idPersonne
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      type: json['Type'],
      id: int.parse(json['id']),
      idPersonne: json['id_personne'] != null ? int.parse(json['id_personne']) : null,
    );
  }

  @override
  List<Object?> get props => [
    type, id,
    idPersonne,
  ];

  toJson() {
    return {
      "title": title,
      "body": body,
      "Type": type,
      "id": id,
      "id_personne": idPersonne,
    };
  }

  static NotificationModel fromString(Map<String, String> object) {
    final Map<String, dynamic> json = object;
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      type: json['Type'],
      id: int.parse(json['id']),
      idPersonne: json['id_personne'] != null ? int.parse(json['id_personne']) : null,
    );


  }

}