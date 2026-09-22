import 'dart:convert';

QrcodeModel qrcodeModelFromJson(String str) => QrcodeModel.fromJson(json.decode(str));

String qrcodeModelToJson(QrcodeModel data) => json.encode(data.toJson());

class QrcodeModel {
  QrcodeModel({
    this.erreur = true,
    required this.ecolecode,
  });

  final bool erreur;
  final String ecolecode;

  factory QrcodeModel.fromJson(Map<String, dynamic> json) => QrcodeModel(
    erreur: json["erreur"] == true,
    ecolecode: json["ecolecode"]?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    "erreur": erreur,
    "ecolecode": ecolecode,
  };
}