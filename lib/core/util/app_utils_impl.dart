import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/features/all_classes/data/models/eleves_by_query_model.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/all_classes/data/models/search_model.dart';
import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:myinoface/core/model/all_gardes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/features/pages/home_page.dart';
import 'package:myinoface/core/model/classes_model.dart';
import 'package:myinoface/core/util/flash_helper.dart';
import 'package:myinoface/core/ui/loading_dialog.dart';
import 'package:myinoface/core/util/url_service.dart';
import 'package:myinoface/core/ui/splash_app.dart';
import 'package:myinoface/core/mobx/mobx_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myinoface/core/util/keys.dart';
import '../notifier/model_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import '../usecases/constants.dart';
import 'app_utils.dart';
import 'dart:convert';
import 'img.dart';



class AppUtilsImpl extends AppUtils {


  SharedPreferences preferences;
  final AppDatabase database;
  final http.Client client;
  var logger = Logger();


  AppUtilsImpl({required this.preferences, required this.client, required this.database});


  @override
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Future<void> logOut() async {
    await database.deleteAllData();
    await preferences.clear();
  }

  @override
  Future<ClassesModel> getAllClasses() async {
    try {
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      if (login == null) throw Exception('No login credentials found');
      var body = {
        'identifiant': login.identifiant.replaceAll(' ', ''),
        'motdepasse': login.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login.tokenmobile.replaceAll(' ', ''),
      };
      final url = UrlService.getUrl(UrlService.getAllClasses);
      logger.i('getAllClasses: $url');
      http.Response response = await client.post(
         Uri.parse(url),
         body: {'inoface_ws': json.encode(body)}
      );
      final classes = classesModelFromJson(response.body);
      if (classes.erreur) {
        logger.e('getAllClasses error: ${classes.message}');
        return classes;
      }
      await database.delete(database.classEntities).go();
      await preferences.setBool(Keys.accesRecuperation, classes.acces_recuperation??false);
      if (classes.classes != null) {
        await database.classEntitiesDao.insertAllClassEntities(classes.classes!);
      }
      networkState.isConnected = true;
      return classes;
    } catch(e) {
      logger.e(e);
      return ClassesModel(erreur: true, message: e.toString());
    }
  }

  @override
  Future confirmRequest(BuildContext context, DemandesRecuperation demRec) async {
    if (networkState.isConnected && context.mounted) {
      return await showDialog(context: context,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            color: Colors.pink,
            padding: const EdgeInsets.all(12),
            child: Text('confirmation'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(
                color: Colors.white
              ),
            ),
          ),
          content: Text('confirmer_demande_récupération'.trArgs([demRec.eleve_nom]),
            style: GoogleFonts.acme(),
          ),
          actions: [
            TextButton(
              child: Text('cancel'.tr,
                style: GoogleFonts.acme(),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('confirm'.tr,
                style: GoogleFonts.acme(),
              ),
              onPressed: () async {
                await _confirmRequest(demRec);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {
      FlashHelper.infoBar(message: 'error_connection'.tr);
    }
  }

  Future _confirmRequest(DemandesRecuperation demRec) async {
    try {
      LoadingDialog.show();
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
        'id_eleve_recuperations': demRec.id_eleve_recuperations,
      };
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.recuperation_ws)),
          body: {'inoface_ws': json.encode(body)}
      );
      LoadingDialog.hide();
      final jsonData = json.decode(response.body);
      if (jsonData['erreur']??true) {
        FlashHelper.errorBar(message: jsonData['message']??'something_wrong'.tr);
      } else {
        await database.demandesRecuperationsDao.deleteDemandesRecuperations(demRec);
        FlashHelper.successBar(message: jsonData['message']);
      }
    } catch(e) {
      logger.e(e);
      LoadingDialog.hide();
    }
  }

  @override
  Future<DemandeRecuperationModel> checkDemandeRecuperation({BuildContext? context, required int idClass}) async {
    final notify = (context != null && context.mounted)
        ? context.read<ModelNotifier>()
        : null;
    try {
      final login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
        'id_classe': idClass,
      };
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.getDemandesRecuperationsByIdClasse)),
          body: {'inoface_ws': json.encode(body)}
      );

      logger.i("getDemandeRecuperation: class=$idClass ${response.body}");
      final model = demandeRecuperationModelFromJson(response.body);
      notify?.setDemandeRecuperationModell(model, initial: true);
      await database.demandesRecuperationsDao.insertAllDemandesRecuperations(model.demandesRecuperations);
      await getAllClasses();
      return model;
    } catch(e) {
      logger.e(e);
      if (context != null && context.mounted) {
        FlashHelper.errorBar(message: 'error_server'.tr);
      }
      return DemandeRecuperationModel(
        erreur: true,
        message: e.toString(),
        Titre: '',
        demandesRecuperations: const [],
      );
    }
  }

  @override
  Future<ClassEntitie> getClassById(int id) async {
    try {
      return await database.classEntitiesDao.getClassEntitieById(id);
    } catch(e) {
      logger.e(e);
      FlashHelper.errorBar(message: 'something_wrong'.tr);
      rethrow;
    }
  }

  @override
  Future<void> logoutDialog(BuildContext context) async {
    final notify = context.read<ModelNotifier>();
    return await showDialog(context: context, builder: (context) => AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        color: Colors.pink,
        height: 55,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(MdiIcons.logout, color: Colors.white),
              const SizedBox(width: 4),
              Text(notify.inputLogin?.identifiant ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
            ],
          ),
        ),
      ),
      content: Text('log_out_msg'.tr),
      actions: <Widget>[
        TextButton(
          child: Text('cancel'.tr),
          onPressed: () => Navigator.pop(context),
        ),

        TextButton(
            child: Text('log_out'.tr),
            onPressed: () async {
              Navigator.pop(context);
              _logOut();
            }
        ),
      ],
    ));
  }



  @override
  Future<void> confirmDemandeRecuperation(BuildContext context, EleveEntitie entitie) async {
    if (networkState.isConnected) {
      return showDialog(context: context,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            color: Colors.pink,
            padding: const EdgeInsets.all(12),
            child: Text('confirmation'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(
                  color: Colors.white
              ),
            ),
          ),
          content: Text('confirmer_demande_récupération'.trArgs([entitie.eleve_nom]),
            style: GoogleFonts.acme(),
          ),
          actions: [
            TextButton(
              child: Text('cancel'.tr,
                style: GoogleFonts.acme(),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('confirm'.tr,
                style: GoogleFonts.acme(),
              ),
              onPressed: () async {
                await _confirmDemandeRecuperation(entitie);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {
      FlashHelper.infoBar(message: 'error_connection'.tr);
    }
  }

  Future _confirmDemandeRecuperation(EleveEntitie entitie) async {
    try {
      LoadingDialog.show();
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
        'id_personne_eleve': entitie.id_personne,
      };
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.add_demanderecuperation_encadrant_ws)),
          body: {'inoface_ws': json.encode(body)}
      );
      logger.i(response.body);
      await getAllClasses();
      LoadingDialog.hide();
      final jsonData = json.decode(response.body);
      if (jsonData['erreur']??true) {
        FlashHelper.errorBar(message: jsonData['message']??'something_wrong'.tr);
      } else {
        await database.eleveEntitiesDao.updateRecuperationsById(
          entitie: entitie, id_eleve_recuperations: jsonData['id_eleve_recuperations']
        );
        FlashHelper.successBar(message: jsonData['message']??"");
      }
    } catch(e) {
      logger.e(e);
      LoadingDialog.hide();
    }
  }

  @override
  Future<void> confirmRemoveRecuperation(BuildContext context, EleveEntitie entitie) async {
    if (networkState.isConnected) {
      return showDialog(context: context,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            color: Colors.pink,
            padding: const EdgeInsets.all(12),
            child: Text('confirmation'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(
                  color: Colors.white
              ),
            ),
          ),
          content: Text('supprimer_demande_récupération'.trArgs([entitie.eleve_nom]),
            style: GoogleFonts.acme(),
          ),
          actions: [
            TextButton(
              child: Text('cancel'.tr,
                style: GoogleFonts.acme(),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('confirm'.tr,
                style: GoogleFonts.acme(),
              ),
              onPressed: () async {
                await _confirmRemoveRecuperation(entitie);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {
      FlashHelper.infoBar(message: 'error_connection'.tr);
    }
  }

  Future _confirmRemoveRecuperation(EleveEntitie entitie) async {
    try {
      LoadingDialog.show();
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
        'id_eleve_recuperations': entitie.id_eleve_recuperations,
      };
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.remove_demanderecuperation_ws)),
          body: {'inoface_ws': json.encode(body)}
      );
      logger.i(response.body);
      await getAllClasses();
      LoadingDialog.hide();
      final jsonData = json.decode(response.body);
      if (jsonData['erreur']??true) {
        FlashHelper.errorBar(message: jsonData['message']??'something_wrong'.tr);
      } else {
        await database.eleveEntitiesDao.updateEleveEntities(
            EleveEntitie(
              id_personne: entitie.id_personne,
              eleve_photo: entitie.eleve_photo,
              id_classe: entitie.id_classe,
              eleve_nom: entitie.eleve_nom,
              id_eleve_recuperations: null,
              prenom: entitie.prenom,
              nom: entitie.nom,
            ),
        );
        FlashHelper.successBar(message: jsonData['message']??"");
      }
    } catch(e) {
      logger.e(e);
      LoadingDialog.hide();
    }
  }


  @override
  Future<AllGardesModel> getAllGardes() async {
    try {
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      if (login == null) {
        return AllGardesModel(erreur: true, message: 'No login credentials found');
      }
      var body = {
        'identifiant': login.identifiant.replaceAll(' ', ''),
        'motdepasse': login.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login.tokenmobile.replaceAll(' ', ''),
      };
      logger.i('getAllGardes identifiant: ${login.identifiant}');
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.getAllGardesByDate_ws)),
          body: {'inoface_ws': json.encode(body)}
      );
      logger.i('getAllGardes: ${response.body}');
      return allGardesModelFromJson(response.body);
    } catch(e) {
      logger.e(e);
      return AllGardesModel(erreur: true, message: e.toString());
    }
  }

  @override
  Future<SearchModel> fetchEleve(String query) async {
    try {
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
        'query': query,
      };
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.AutoCompleteSearch_ws)),
          body: {'inoface_ws': json.encode(body)}
      );
      logger.i('fetchEleve: ${response.body}');
      return searchModelFromJson(response.body);
    } catch(e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ElevesByQueryModel> getElevesByQuery(String query) async {
    try {
      InputLoginModel? login = PreferenceUtils.getInputLogin();
      var body = {
        'identifiant': login?.identifiant.replaceAll(' ', ''),
        'motdepasse': login?.motdepasse.replaceAll(' ', ''),
        'tokenmobile': login?.tokenmobile.replaceAll(' ', ''),
        'query': query,
      };
      http.Response response = await client.post(
          Uri.parse(UrlService.getUrl(UrlService.GetElevesByQuery_ws)),
          body: {'inoface_ws': json.encode(body)}
      );
      logger.i('getElevesByQuery: ${response.body}');
      return elevesByQueryModelFromJson(response.body);
    } catch(e) {
      logger.e(e);
      rethrow;
    }
  }

  void _logOut() async {
    await database.deleteAllData();
    await preferences.clear();
    Get.offAll(() => SplashApp(
      duration: 1000,
      home: const HomePage(),
      type: AnimatedSplashType.StaticDuration,
    ));
  }

  @override
  Future<void> showAllClasse(BuildContext context, ClassEntitie classEntitie) async {
    try {
      final MobxApp _mobx = MobxApp();
      ClassEntitie? selectedClass;
      List<ClassEntitie> classes = await database.classEntitiesDao.getClassEntitieByResponsable('Moi');
      logger.i(classes.length.toString());
      if (classes.isNotEmpty) {
        return showDialog(context: context, builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)
                ),
              ),
              child: Text('choose_class'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.acme(
                  color: Colors.white
                ),
              ),
            ),
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              height: Get.height/1.8,
              width: Get.width,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final model = classes[index];
                  return ListTile(
                    onTap: () {
                      selectedClass = model;
                      _mobx.setIndexClass(index);
                    },
                    trailing: Observer(
                      builder: (_) {
                        if (_mobx.indexClass == index) {
                          return Icon(MdiIcons.checkCircle, color: Colors.pink);
                        } else {
                          return Icon(MdiIcons.checkboxBlankCircleOutline);
                        }
                      },
                    ),
                    leading: Image.asset(
                      IMG.classes, color: Colors.pink,
                      height: 28, width: 28,
                    ),
                    title: Text(model.classe_description),
                    subtitle: Text("${model.niveau} ${(model.Responsable != null) ? '/ ${model.Responsable}' : ''} "),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text('cancel'.tr),
                onPressed: () => Navigator.pop(context),
              ),

              Observer(
                builder: (_) {
                  return TextButton(
                    child: Text('confirmation'.tr),
                    onPressed: _mobx.indexClass != null ? () async {
                      if (selectedClass != null) {
                        LoadingDialog.show();
                        await checkDemandeRecuperation(idClass: selectedClass!.id_classe, context: context);
                        LoadingDialog.hide();
                        Navigator.pop(context);
                      }
                    } : null,
                  );
                },
              ),

            ],
          );
        });
      } else {
        FlashHelper.infoBar(message: 'no_result_found'.tr);
      }
    } catch(e) {
      logger.e('$e');
    }
  }

  @override
  dynamic checkResponsableColor(ClassEntitie model) {
    try {
      if (model.Responsable == null) {
        return Colors.pink;
      } else if (model.Responsable!.contains('Moi')) {
        return const Color(0xFF1EE9A4);
      } else {
        return Colors.pink;
      }
    } catch(e) {
      return Colors.pink;
    }
  }

  @override
  String checkResponsable(ClassEntitie model) {
    try {
      if (model.Responsable != null && model.Responsable != 'Moi') {
        return ' / ${model.Responsable}';
      } else {
        return '';
      }
    } catch(e) {
      return '';
    }
  }

  @override
  String checkTitre(DemandeRecuperationModel model) {
    if (model.Titre.contains('|')) {
      final lig = model.Titre.length;
      final end = lig~/2;
      final titre = model.Titre.substring(0, end);
      return '$titre...';
    } else {
      return model.Titre;
    }
  }

  @override
  Future<void> showDemandeTitle(BuildContext context, DemandeRecuperationModel model) async {
    await showDialog(context: context, builder: (context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.pink,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Text(model.Titre,
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    });
  }
}