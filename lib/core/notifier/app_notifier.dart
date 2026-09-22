import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class AppNotifier extends ChangeNotifier {

  // final NetworkInfo networkInfo;
  final SharedPreferences preferences;
  final http.Client client;
  final AppDatabase database;


  AppNotifier({
    required this.preferences,
    required this.client,
    required this.database
  });

  var logger = Logger();
}