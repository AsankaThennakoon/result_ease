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
    apiKey: 'AIzaSyCKiv2bboIsNpcx6ERbuonBo0i5O7aqFxE',
    appId: '1:495265433358:web:1c0e30730f984bbec4795f',
    messagingSenderId: '495265433358',
    projectId: 'result-ease',
    authDomain: 'result-ease.firebaseapp.com',
    storageBucket: 'result-ease.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_SzDIQ8OMi6E-Y7xGWjml2ral0KwTWwo',
    appId: '1:495265433358:android:e6582f41c6f43e82c4795f',
    messagingSenderId: '495265433358',
    projectId: 'result-ease',
    storageBucket: 'result-ease.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtdB13ecdWRYVcrf217ztz4njhMAKQPqo',
    appId: '1:495265433358:ios:3f9b5fc71c6ee32fc4795f',
    messagingSenderId: '495265433358',
    projectId: 'result-ease',
    storageBucket: 'result-ease.appspot.com',
    iosBundleId: 'com.example.resultEase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtdB13ecdWRYVcrf217ztz4njhMAKQPqo',
    appId: '1:495265433358:ios:3f9b5fc71c6ee32fc4795f',
    messagingSenderId: '495265433358',
    projectId: 'result-ease',
    storageBucket: 'result-ease.appspot.com',
    iosBundleId: 'com.example.resultEase',
  );
}
