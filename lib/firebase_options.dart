// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDkiOfo6IbmOuFUqDF4XK2LsTCke4q4_wU',
    appId: '1:757279698129:web:91067da1b294a67b7169f0',
    messagingSenderId: '757279698129',
    projectId: 'reflekt-journal-a436b',
    authDomain: 'reflekt-journal-a436b.firebaseapp.com',
    storageBucket: 'reflekt-journal-a436b.firebasestorage.app',
    measurementId: 'G-NPNTB0PDHF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDihYafE-5bed2QqvjSCKNQ9XVhEI70g2o',
    appId: '1:757279698129:android:bf02ee56e7d059137169f0',
    messagingSenderId: '757279698129',
    projectId: 'reflekt-journal-a436b',
    storageBucket: 'reflekt-journal-a436b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjTtJvgLlTDDxhV5Vf_JZiFWOmGpckgLA',
    appId: '1:757279698129:ios:6f543c8b186f9d697169f0',
    messagingSenderId: '757279698129',
    projectId: 'reflekt-journal-a436b',
    storageBucket: 'reflekt-journal-a436b.firebasestorage.app',
    iosBundleId: 'com.yourname.reflekt.reflektApp',
  );
}
