// Android and iOS Firebase apps for com.inoser.myinoface.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Firebase is not configured for web.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7nmIia108ofoqSypoQLG-14h7UM8FqxU',
    appId: '1:256012514157:android:42324aedb5f6f51b8d2064',
    messagingSenderId: '256012514157',
    projectId: 'myinoface',
    storageBucket: 'myinoface.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7nmIia108ofoqSypoQLG-14h7UM8FqxU',
    appId: '1:256012514157:ios:42324aedb5f6f51b8d2064',
    messagingSenderId: '256012514157',
    projectId: 'myinoface',
    storageBucket: 'myinoface.appspot.com',
    iosBundleId: 'com.inoser.myinoface',
  );
}
