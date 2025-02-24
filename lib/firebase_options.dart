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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAaxF71_leKFLD6h_HyUT3NAgSnTF4ICMQ',
    appId: '1:286628788257:web:3bab5ec3fbc83ee51acb60',
    messagingSenderId: '286628788257',
    projectId: 'stockmanagement-5db68',
    authDomain: 'stockmanagement-5db68.firebaseapp.com',
    storageBucket: 'stockmanagement-5db68.appspot.com',
    measurementId: 'G-69VDVW6KMK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDp8wlfa4YUjJixreIfZqAhfeO2Fh_nvsk',
    appId: '1:286628788257:android:007abf84d0b2ec851acb60',
    messagingSenderId: '286628788257',
    projectId: 'stockmanagement-5db68',
    storageBucket: 'stockmanagement-5db68.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8ZeYFnVujjw8914DNWk10UJGaQonRjHA',
    appId: '1:286628788257:ios:05097f9fbc0f9e9b1acb60',
    messagingSenderId: '286628788257',
    projectId: 'stockmanagement-5db68',
    storageBucket: 'stockmanagement-5db68.appspot.com',
    iosBundleId: 'com.example.srockManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8ZeYFnVujjw8914DNWk10UJGaQonRjHA',
    appId: '1:286628788257:ios:05097f9fbc0f9e9b1acb60',
    messagingSenderId: '286628788257',
    projectId: 'stockmanagement-5db68',
    storageBucket: 'stockmanagement-5db68.appspot.com',
    iosBundleId: 'com.example.srockManagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAaxF71_leKFLD6h_HyUT3NAgSnTF4ICMQ',
    appId: '1:286628788257:web:9836d2d832d1f95b1acb60',
    messagingSenderId: '286628788257',
    projectId: 'stockmanagement-5db68',
    authDomain: 'stockmanagement-5db68.firebaseapp.com',
    storageBucket: 'stockmanagement-5db68.appspot.com',
    measurementId: 'G-96EZY7B5GZ',
  );
}
