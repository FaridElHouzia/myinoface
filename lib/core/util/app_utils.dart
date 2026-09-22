import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/features/all_classes/data/models/eleves_by_query_model.dart';
import 'package:myinoface/features/all_classes/data/models/search_model.dart';
import 'package:myinoface/core/model/all_gardes_model.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/model/classes_model.dart';
import 'package:flutter/material.dart';



abstract class AppUtils extends ChangeNotifier {

  String generateMd5(String input);
  Future<void> logOut();
  Future<ClassesModel> getAllClasses();
  Future confirmRequest(BuildContext context, DemandesRecuperation demRec);
  Future<DemandeRecuperationModel> checkDemandeRecuperation({BuildContext? context, required int idClass});
  Future<ClassEntitie> getClassById(int id);
  Future<void> logoutDialog(BuildContext context);
  Future<void> confirmDemandeRecuperation(BuildContext context, EleveEntitie entitie);
  Future<void> confirmRemoveRecuperation(BuildContext context, EleveEntitie entitie);
  Future<AllGardesModel> getAllGardes();
  Future<SearchModel> fetchEleve(String query);
  Future<ElevesByQueryModel> getElevesByQuery(String query);
  Future<void> showAllClasse(BuildContext context, ClassEntitie classEntitie);
  dynamic checkResponsableColor(ClassEntitie model);
  String checkResponsable(ClassEntitie model);
  String checkTitre(DemandeRecuperationModel model);
  Future<void> showDemandeTitle(BuildContext context, DemandeRecuperationModel model);

}
