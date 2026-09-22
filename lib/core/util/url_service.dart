import 'package:myinoface/core/usecases/preference_utils.dart';
import 'keys.dart';

class UrlService {
  static const String inoserHost = 'inoser-education.com';
  static const String inoserOrigin = 'https://$inoserHost';

  // static String login = 'login_admin_ws';
  static String login = 'login_ws';
  static String getAllClasses = 'GetAllClasses_ws';
  static String getAllGardesByDate_ws = 'GetAllGardesByDate_ws';
  static String AutoCompleteSearch_ws = 'AutoCompleteSearch_ws';
  static String GetElevesByQuery_ws = 'GetElevesByQuery_ws';
  // static String loginWithQrcode = 'login_admin_with_Qrcode_ws';
  static String loginWithQrcode = 'login_with_Qrcode_ws';
  static String recuperation_ws = 'Recuperation_ws';
  static String add_demanderecuperation_encadrant_ws = 'add_demanderecuperation_encadrant_ws';
  static String remove_demanderecuperation_ws = 'remove_demanderecuperation_ws';
  static String getDemandesRecuperationsByIdClasse = 'GetDemandesRecuperationsByIdClasse';
  static String GetElevesByIdClasse_ws = 'GetElevesByIdClasse_ws';
  static String GetPersonneGardeByDate_ws = 'GetPersonneGardeByDate_ws';
  static String getUrlFromQrcode = '$inoserOrigin/lescopains/json/GetUrlFromQrcode_ws';
  static const FORGIT_PASSWORD = "Forget_password_ws";
  static const GetParentsByid_ws = "GetParentsByid_ws";
  static const GetParentCinByid_ws = "GetParentCinByid_ws";

  static String currentCodeSchool() {
    return PreferenceUtils.getString(Keys.codeSchool).trim();
  }

  static String getUrl(String service) {
    final codeSchool = currentCodeSchool();
    if (codeSchool.isEmpty) {
      throw StateError('School code is missing. Enter it on the login form.');
    }
    return '$inoserOrigin/$codeSchool/json/$service';
  }

  /// Upgrade Inoser media URLs returned as http:// by the API.
  static String rewriteInoserUri(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host.isEmpty) {
      return url;
    }
    final host = uri.host.toLowerCase();
    if (host == inoserHost || host.endsWith('.$inoserHost')) {
      return uri.replace(scheme: 'https').toString();
    }
    return url;
  }

  static String? rewriteInoserUriOrNull(String? url) {
    if (url == null || url.isEmpty) {
      return url;
    }
    return rewriteInoserUri(url);
  }
}
