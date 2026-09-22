import 'package:equatable/equatable.dart';
import 'dart:convert';


class InputQrcodeModel extends Equatable {

  //final String token;
  final String scancode;
  final String tokenmobile;


  const InputQrcodeModel({
    required this.scancode,
    required this.tokenmobile,
  });

  Map<String, dynamic> toJson() {
    return {
      'scancode': scancode,
      'tokenmobile': tokenmobile,
    };
  }

  @override
  String toString() {
    var body = {
      'scancode': scancode.replaceAll(' ', ''),
      'tokenmobile': tokenmobile.replaceAll(' ', ''),
    };
    return json.encode(body);
  }

  @override
  List<Object> get props => [scancode, tokenmobile];


}