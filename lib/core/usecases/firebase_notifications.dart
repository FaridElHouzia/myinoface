import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/features/demande_recuperation/data/models/demande_recuperation_model.dart';
import 'package:myinoface/features/demande_recuperation/presentation/widgets/loaded_demande_recuperation_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myinoface/core/model/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'constants.dart';
import 'dart:convert';
import 'dart:io';

class FirebaseNotifications {
  static FirebaseMessaging get _instance => _firebaseMessaging ??= FirebaseMessaging.instance;
  static FirebaseNotifications? _firebaseNotifications;
  static FirebaseMessaging? _firebaseMessaging;

  static Future<void> setUpFirebase() async {
    _firebaseMessaging ??= _instance;
    _firebaseNotifications ??= FirebaseNotifications();

    final settings = await _firebaseMessaging?.requestPermission(
      criticalAlert: false,
      announcement: false,
      provisional: false,
      carPlay: false,
      badge: true,
      alert: true,
      sound: true,
    );

    await _firebaseMessaging?.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    logger.i('User granted permission: ${settings?.authorizationStatus}');
    if (settings?.authorizationStatus == AuthorizationStatus.authorized) {
      logger.i('User granted permission');
    } else if (settings?.authorizationStatus == AuthorizationStatus.provisional) {
      logger.i('User granted provisional permission');
    } else {
      logger.i('User declined or has not accepted permission');
    }

    // if (Platform.isIOS) {
    //   final bool result = await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //       IOSFlutterLocalNotificationsPlugin>()
    //       ?.requestPermissions(
    //     alert: true,
    //     badge: true,
    //     sound: true,
    //   );
    // }
  }

  static void messagingListeners(BuildContext context) {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        if (message.data.isNotEmpty) {
          logger.i('Message data: onMessage ${message.data}');
          // final entity = NotificationModel.fromJson(message.data);
          AndroidNotification? android = message.notification?.android;
          RemoteNotification? notification = message.notification;
          //! TODO: By Mazen
          // await flutterLocalNotificationsPlugin.show(
          //   message.hashCode,
          //   notification?.title ?? '',
          //   notification?.body ?? '',
          //   NotificationDetails(
          //     android: AndroidNotificationDetails(
          //       channel.id,
          //       channel.name,
          //       channel.description,
          //       priority: Priority.high,
          //       importance: Importance.max,
          //       icon: android?.smallIcon,
          //     ),
          //     iOS: const IOSNotificationDetails(),
          //   ),
          //   payload: json.encode(message.data),
          // );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        if (message.data.isNotEmpty) {
          logger.i('onMessageOpenedApp payload 1');
          final NotificationModel entity = NotificationModel.fromJson(message.data);
          // final entity = NotificationModel.fromJson(message.data);
          final demandModel = await appUtils.checkDemandeRecuperation(context: context, idClass: entity.id);
          final classModel = await appUtils.getClassById(entity.id);
          Get.to(() => LoadedDemandeRecuperationWidget(
                classEntitie: classModel,
                model: demandModel,
              ));
        } else {
          var details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
          //! TODO: By Mazen
          // if ((details?.didNotificationLaunchApp ?? false) && details?.payload != null) {
          //   logger.i('onMessageOpenedApp payload 2');
          //   if (details?.payload?.isEmpty ?? false) return;
          //   final entity = NotificationModel.fromJson(json.decode(details?.payload ?? ''));
          //   final demandModel = await appUtils.checkDemandeRecuperation(context: context, idClass: entity.id);
          //   final classModel = await appUtils.getClassById(entity.id);
          //   Get.to(() => LoadedDemandeRecuperationWidget(
          //         classEntitie: classModel,
          //         model: demandModel,
          //       ));
          // }
        }
      });

      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
        if (message?.data.isNotEmpty ?? false) {
          logger.i('getInitialMessage payload 1');
          // final NotificationModel entity = NotificationModel.fromString(message?.data??'');
          final entity = NotificationModel.fromJson(message!.data);
          final demandModel = await appUtils.checkDemandeRecuperation(context: context, idClass: entity.id);
          final classModel = await appUtils.getClassById(entity.id);
          Get.to(() => LoadedDemandeRecuperationWidget(
                classEntitie: classModel,
                model: demandModel,
              ));
        } else {
          var details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
          //! TODO: By Mazen
          // if ((details?.didNotificationLaunchApp ?? false) && details?.payload != null) {
          //   logger.i('getInitialMessage payload 2');
          //   final entity = NotificationModel.fromJson(json.decode(details?.payload ?? ''));
          //   final demandModel = await appUtils.checkDemandeRecuperation(context: context, idClass: entity.id);
          //   final classModel = await appUtils.getClassById(entity.id);
          //   Get.to(() => LoadedDemandeRecuperationWidget(
          //     classEntitie: classModel,
          //     model: demandModel,
          //   ));
          // }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  static Future selectNotification(BuildContext context, String? payload) async {
    logger.i('currentRoute: ${Get.currentRoute}');
    logger.i('selectNotification payload 1');
    if (payload != null) {
      final entity = NotificationModel.fromJson(json.decode(payload));
      final demandModel = await appUtils.checkDemandeRecuperation(context: context, idClass: entity.id);
      final classModel = await appUtils.getClassById(entity.id);

      Get.to(() => LoadedDemandeRecuperationWidget(
            classEntitie: classModel,
            model: demandModel,
          ));
    } else {
      var details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
      //! TODO: By Mazen
      // if ((details?.didNotificationLaunchApp ?? false) && details?.payload != null) {
      //   logger.i('selectNotification payload 2');
      //   final NotificationModel entity = NotificationModel.fromJson(json.decode(details?.payload ?? ''));
      //   final DemandeRecuperationModel demandModel = await appUtils.checkDemandeRecuperation(context: context, idClass: entity.id);
      //   final ClassEntitie classModel = await appUtils.getClassById(entity.id);
      //   Get.to(() => LoadedDemandeRecuperationWidget(
      //     classEntitie: classModel,
      //     model: demandModel,
      //   ));
      // }
    }
  }

  static Future<String?> getToken() async {
    try {
      if (Platform.isIOS) {
        for (int i = 0; i < 5; i++) {
          try {
            final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
            if (apnsToken != null) break;
          } catch (_) {}
          await Future.delayed(const Duration(seconds: 2));
        }
      }
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      logger.e(e);
      return '';
    }
  }
}
