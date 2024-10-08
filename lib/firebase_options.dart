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
    apiKey: 'AIzaSyDnL0qs1-GIHuPzIagkAXuhWLNxg51W2Vs',
    appId: '1:1093433096575:web:e56eae63f19f3dbb33824a',
    messagingSenderId: '1093433096575',
    projectId: 'worktimer2c',
    authDomain: 'worktimer2c.firebaseapp.com',
    storageBucket: 'worktimer2c.appspot.com',
    measurementId: 'G-FM9CCJQSFQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeCPAOeQiuVxUmBZcEUnJIKw-dsOWmorY',
    appId: '1:1093433096575:android:e7b97a9b7267eb2233824a',
    messagingSenderId: '1093433096575',
    projectId: 'worktimer2c',
    storageBucket: 'worktimer2c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDj306syuezQdTr1fiZ_FQhyTTiAIapA0k',
    appId: '1:1093433096575:ios:09b88b467adedc4633824a',
    messagingSenderId: '1093433096575',
    projectId: 'worktimer2c',
    storageBucket: 'worktimer2c.appspot.com',
    iosBundleId: 'com.example.worktime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDj306syuezQdTr1fiZ_FQhyTTiAIapA0k',
    appId: '1:1093433096575:ios:09b88b467adedc4633824a',
    messagingSenderId: '1093433096575',
    projectId: 'worktimer2c',
    storageBucket: 'worktimer2c.appspot.com',
    iosBundleId: 'com.example.worktime',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDnL0qs1-GIHuPzIagkAXuhWLNxg51W2Vs',
    appId: '1:1093433096575:web:31c6b32fc0b6b85133824a',
    messagingSenderId: '1093433096575',
    projectId: 'worktimer2c',
    authDomain: 'worktimer2c.firebaseapp.com',
    storageBucket: 'worktimer2c.appspot.com',
    measurementId: 'G-6WW4NKQSQ1',
  );

}