// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDa5Q-dDGoVY1RM92bBQEchRhajstDmynM',
    appId: '1:854310981691:web:9db23ee8410f73144c8c1e',
    messagingSenderId: '854310981691',
    projectId: 'homebar-77343',
    authDomain: 'homebar-77343.firebaseapp.com',
    storageBucket: 'homebar-77343.appspot.com',
    measurementId: 'G-H4B910RRJJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8E7C9HlVSVY1yLRP2NTCcLdRZwPDKC4I',
    appId: '1:854310981691:android:298d8c3d29f660344c8c1e',
    messagingSenderId: '854310981691',
    projectId: 'homebar-77343',
    storageBucket: 'homebar-77343.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmceISgygem4AsLBE1aCAkXAUm3KPg3wA',
    appId: '1:854310981691:ios:2be7fb11d6bb5abf4c8c1e',
    messagingSenderId: '854310981691',
    projectId: 'homebar-77343',
    storageBucket: 'homebar-77343.appspot.com',
    iosBundleId: 'com.example.flutterApplicationHomebar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmceISgygem4AsLBE1aCAkXAUm3KPg3wA',
    appId: '1:854310981691:ios:dc52a0658c4c41e64c8c1e',
    messagingSenderId: '854310981691',
    projectId: 'homebar-77343',
    storageBucket: 'homebar-77343.appspot.com',
    iosBundleId: 'com.example.flutterApplicationHomebar.RunnerTests',
  );
}
