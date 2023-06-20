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
    apiKey: 'AIzaSyCCA67dayeR-NHCwQTu_fj_ZPNx4Q9dJxM',
    appId: '1:76504261102:web:35bf83c5966b1de44deeff',
    messagingSenderId: '76504261102',
    projectId: 'fandome-7f9ba',
    authDomain: 'fandome-7f9ba.firebaseapp.com',
    storageBucket: 'fandome-7f9ba.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-rb4-z9pfTrCTcyqPhgRcs9d0QOOBmHQ',
    appId: '1:76504261102:android:418863043df4ef2c4deeff',
    messagingSenderId: '76504261102',
    projectId: 'fandome-7f9ba',
    storageBucket: 'fandome-7f9ba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLamloTRgXE2d_bU16KRz9JLct3BK04PI',
    appId: '1:76504261102:ios:dc1a1765fbc4b21a4deeff',
    messagingSenderId: '76504261102',
    projectId: 'fandome-7f9ba',
    storageBucket: 'fandome-7f9ba.appspot.com',
    iosClientId: '76504261102-6dk812mnbhqsd530ur9h6f4ph283sq91.apps.googleusercontent.com',
    iosBundleId: 'com.example.testproj',
  );
}
