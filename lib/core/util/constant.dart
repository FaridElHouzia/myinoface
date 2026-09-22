import 'package:flutter/material.dart';


// Colors
const backgroundColor = Color(0xFFFEFEFE);
const titleTextColor = Color(0xFF303030);
const bodyTextColor = Color(0xFF4B4B4B);
const textLightColor = Color(0xFF959595);
const infectedColor = Color(0xFFFF8748);
const deathColor = Color(0xFFFF4848);
const recoverColor = Color(0xFF36C12C);
const primaryColor = Color(0xFF3382CC);
final shadowColor = Color(0xFFB7B7B7).withValues(alpha: .16);
final activeShadowColor = Color(0xFF4056C6).withValues(alpha: .15);

final Map<DateTime, List> holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

// Text Style
const headingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const subTextStyle = TextStyle(fontSize: 16, color: textLightColor);

const titleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.pink,
  fontWeight: FontWeight.bold,
);

/*
class Constant {

  static const String FIRST_TIME_PAGE = '/';
  static const String HOME_PAGE = '/home';
  static const String SETTINGS_PAGE = '/settings';
  static const String LOGIN_PAGE = '/login';
  static const String SPLASH_PAGE = '/splash';
  static const String SEND_FEEDBACK = '/send_feedback';
  static const String INIT_HOME = '/init_home';
  static const String CUSTOM_DIALOG_IMAGE = '/custom_dialog_image';
  static const String APP_TUTORIAL = '/app_tutorial';
  static const String AGENDA_NOTES = '/agenda_notes';
  static const String GALLERY_PAGE = '/gallery';

}
 */