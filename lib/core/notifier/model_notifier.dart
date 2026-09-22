import '../../features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/features/login/domain/usecases/input_login_model.dart';
import 'package:myinoface/features/login/data/models/login_model.dart';
import 'package:myinoface/core/model/all_gardes_model.dart';
import 'package:myinoface/core/model/classes_model.dart';
import 'package:flutter/material.dart';



class ModelNotifier extends ChangeNotifier {


  //! LoginModel
  LoginModel? _loginModel;
  LoginModel? get loginModel => _loginModel;

  setLoginModel(LoginModel val) {
    _loginModel = val;
    notifyListeners();
  }

  //! InputLogin
  InputLoginModel? _inputLogin;
  InputLoginModel? get inputLogin => _inputLogin;

  setInputLogin(InputLoginModel val) {
    _inputLogin = val;
    notifyListeners();
  }

  //! ClassesModel
  ClassesModel? _classes;
  ClassesModel? get classes => _classes;

  setClassesModel(ClassesModel val) {
    _classes = val;
    notifyListeners();
  }

  //! AllGardesModel
  AllGardesModel? _allGardesModel;
  AllGardesModel? get allGardesModel => _allGardesModel;

  setAllGardesModel(AllGardesModel model) {
    _allGardesModel = model;
    notifyListeners();
  }

  // DateTime _dateTimeLocal;
  // DateTime get dateTimeLocal => _dateTimeLocal;
  //
  // setDateTimeLocal(DateTime val) {
  //   _dateTimeLocal = val;
  //   notifyListeners();
  // }

  logout() {
    _loginModel = null;
    _inputLogin = null;
    notifyListeners();
  }


  //! DemandeRecuperationModel
  DemandeRecuperationModel? _demandeRecuperationModel;
  DemandeRecuperationModel? get demandeRecuperationModel => _demandeRecuperationModel;

  setDemandeRecuperationModell(DemandeRecuperationModel model, {bool initial = true}) {
    _demandeRecuperationModel = model;
    if (initial) notifyListeners();
  }
}