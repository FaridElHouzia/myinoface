import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/usecases/firebase_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'core/model/reminder_notification.dart';
import 'core/usecases/preference_utils.dart';
import 'core/notifier/model_notifier.dart';
import 'core/network/network_logic.dart';
import 'core/network/inoser_http_overrides.dart';
import 'core/database/app_database.dart';
import 'package:provider/provider.dart';
import 'features/pages/home_page.dart';
import 'core/util/app_utils_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/usecases/constants.dart';
import 'core/utils/utils_logic.dart';
import 'core/langs/translation.dart';
import 'core/util/color_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'core/ui/splash_app.dart';
import 'package:get/get.dart';
import 'core/util/keys.dart';
import 'dart:async';





const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'high_importance_channel',
  // 'High Importance Notifications',//! TODO: By Mazen
  importance: Importance.max, playSound: true,
);

final BehaviorSubject<ReminderNotification> didReceiveNotificationSubject = BehaviorSubject<ReminderNotification>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializePlatformSpecifics() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  var initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/ic_stat_name');
  var initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  //! TODO: By Mazen
  // var initializationSettingsIOS = IOSInitializationSettings(
  //   requestAlertPermission: true,
  //   requestBadgePermission: true,
  //   requestSoundPermission: true,
  //   onDidReceiveLocalNotification: (int? id, String? title, String? body, String? payload) async {
  //     ReminderNotification receivedNotification = ReminderNotification(
  //         id: id, title: title, body: body, payload: payload);
  //     didReceiveNotificationSubject.add(receivedNotification);
  //     FirebaseNotifications.selectNotification;
  //   },
  // );
  //! TODO: By Mazen
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  tz.initializeTimeZones();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      final payload = response.payload;
      if (payload != null && Get.context != null) {
        await FirebaseNotifications.selectNotification(Get.context!, payload);
      }
    },
  );
}

Timer interval(Duration duration, func) {
  Timer function() {
    Timer timer = Timer(duration, function);
    func(timer);
    return timer;
  }
  return Timer(duration, function);
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  installInoserHttps();
  var db = AppDatabase.instance;
  try {
    await Firebase.initializeApp();
    await FirebaseNotifications.setUpFirebase();
  } catch (e) {
    debugPrint('Firebase init skipped: $e');
  }
  // await FlutterDownloader.initialize(debug: false);
  await di.setup();
  initializePlatformSpecifics();
  Get.put(NetworkLogic(), permanent: true);
  Get.put(UtilsLogic(), permanent: true);
  await networkLogic.hasConnection();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  int i = 0;
  // final AppUtils appUtils = GetIt.I.get<AppUtils>();
  interval(const Duration(seconds: 1), (Timer timer) {
    i++;
    if (i > 8) {
      i = 0;
      if (PreferenceUtils.getInputLogin() != null) {
        appUtils.getAllClasses().ignore();
      }
    }
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppUtilsImpl(
          preferences: di.sl(),
          client: di.sl(),
          database: db,
        )),
        Provider<AppDatabase>(
          create: (_) => db,
          dispose: (context, value) => value.close(),
        ),
        ChangeNotifierProvider(create: (_) => ModelNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyInoface',
      translations: Translation(),
      locale: Locale(PreferenceUtils.getString(Keys.local, 'fr')),
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('ar', 'AR'),
      ],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: ColorHelper.COLOR_PINK,
        primaryTextTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white,),
          bodyMedium: TextStyle(color: Colors.white,),
        ),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashApp(
        duration: 1000,
        home: const HomePage(),
        type: AnimatedSplashType.StaticDuration,
      )
    );
  }
}
