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

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyCT6igr2cmhQgrEQYbQqBwfLtsjbUo5Mz4',
      appId: '1:824893113729:android:0aad093c40b0ce7b091480',
      messagingSenderId: '824893113729',
      projectId: 'soldout-b8dd0',
      storageBucket: 'soldout-b8dd0.appspot.com',
      androidClientId: '824893113729-4bnpvpmotuttha286m9q8vngap32i7hk.apps.googleusercontent.com',
      deepLinkURLScheme: 'https://soldouta.page.link/'
  );

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyAeEOWq3FTw-0V0LTfDP0nbGPO0hEG-fJ4',
      appId: '1:824893113729:ios:c2f5d6bf521e63ec091480',
      messagingSenderId: '824893113729',
      projectId: 'soldout-b8dd0',
      storageBucket: 'soldout-b8dd0.appspot.com',
      //iosClientId: '441146186016-qnm32s25oeffmadmqrhkg92oo21aflv1.apps.googleusercontent.com',
      iosBundleId: 'com.soldout.sa',
      deepLinkURLScheme: 'https://soldouta.page.link/'
  );

}