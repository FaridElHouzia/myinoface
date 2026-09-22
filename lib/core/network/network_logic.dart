import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/services.dart';
import '../usecases/constants.dart';
import 'package:get/get.dart';
import 'network_state.dart';
import 'dart:async';

class NetworkLogic extends GetxController implements GetxService {
  static NetworkLogic instance = Get.find();
  final state = NetworkState();

  StreamSubscription? _streamSubscription;
  final InternetConnectionChecker _checker =
      InternetConnectionChecker.instance;

  @override
  void onInit() {
    _checker.addresses = [
      AddressCheckOption(uri: Uri.parse('https://inoser-education.com')),
      AddressCheckOption(uri: Uri.parse('https://one.one.one.one')),
      AddressCheckOption(uri: Uri.parse('https://dns.google')),
    ];
    _streamSubscription = _checker.onStatusChange.listen(_updateState);
    super.onInit();
  }

  @override
  void onReady() {
    hasConnection();
    super.onReady();
  }


  Future<void> getConnectionType() async {
    InternetConnectionStatus? result;
    try {
      result = await _checker.connectionStatus;
    } on PlatformException catch (e) {
      logger.e(e);
    }
    if (result != null) {
      return _updateState(result);
    }
  }

  Future<void> hasConnection() async {
    try {
      state.isConnected = await _checker.hasConnection;
      update();
      logger.v('Data connection is ${state.isConnected}');
    } on PlatformException catch (e) {
      logger.e(e);
    }
  }

  void _updateState(InternetConnectionStatus status) {
    logger.v('Connection Status: ${status.name}');
    switch (status) {
      case InternetConnectionStatus.connected:
      case InternetConnectionStatus.slow:
        logger.v('Data connection is true');
        state.isConnected = true;
        update();
        break;
      case InternetConnectionStatus.disconnected:
        logger.v('Data connection is false');
        state.isConnected = false;
        update();
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
  }
}
