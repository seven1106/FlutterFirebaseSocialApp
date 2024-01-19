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
    apiKey: 'AIzaSyAiXihXyiaDzmejr8VVfAxSPph4mfWzDGk',
    appId: '1:114956842271:web:45c72165a6597143e62c2a',
    messagingSenderId: '114956842271',
    projectId: 'flutter-socialapp-ed924',
    authDomain: 'flutter-socialapp-ed924.firebaseapp.com',
    storageBucket: 'flutter-socialapp-ed924.appspot.com',
    measurementId: 'G-D1L6WT9NRP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDo9nJg7oaenOT7QRcBEO2nd7lg9LZpjv4',
    appId: '1:114956842271:android:124e4ed8845757f2e62c2a',
    messagingSenderId: '114956842271',
    projectId: 'flutter-socialapp-ed924',
    storageBucket: 'flutter-socialapp-ed924.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9U0HkxbipvR4gf4haD6I6q5tIWRnSGMA',
    appId: '1:114956842271:ios:ae923cf9ae0e9548e62c2a',
    messagingSenderId: '114956842271',
    projectId: 'flutter-socialapp-ed924',
    storageBucket: 'flutter-socialapp-ed924.appspot.com',
    iosBundleId: 'com.example.untitled',
  );
}