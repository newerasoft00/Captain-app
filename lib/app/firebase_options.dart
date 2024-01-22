import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCLfJcP0VF0V9r8gjupckTo_WMFZbGpVWA',
    appId: '1:681994242014:web:891e065cf85fc568f6bf4f',
    messagingSenderId: '681994242014',
    projectId: 'roshn-bet',
    authDomain: 'roshn-bet.firebaseapp.com',
    storageBucket: 'roshn-bet.appspot.com',
    measurementId: 'G-LJ1FB30MC8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbLmxwr9zkstm94MMQCypgbVAewk9clis',
    appId: '1:681994242014:android:f6511722055298e1f6bf4f',
    messagingSenderId: '681994242014',
    projectId: 'roshn-bet',
    storageBucket: 'roshn-bet.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyAQaaUevo0U1-uqBhWjRmiEtUFVqU1pA',
    appId: '1:681994242014:ios:610738d1585e8be4f6bf4f',
    messagingSenderId: '681994242014',
    projectId: 'roshn-bet',
    storageBucket: 'roshn-bet.appspot.com',
    androidClientId:
        '681994242014-e1ka22f7g7p63fb10dhrim96s45rds1f.apps.googleusercontent.com',
    iosClientId:
        '681994242014-69hniht66ppus2kmleiqgs86oam9ejrt.apps.googleusercontent.com',
    iosBundleId: 'com.newera.captainapppp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyAQaaUevo0U1-uqBhWjRmiEtUFVqU1pA',
    appId: '1:681994242014:ios:55968128a0b8b714f6bf4f',
    messagingSenderId: '681994242014',
    projectId: 'roshn-bet',
    storageBucket: 'roshn-bet.appspot.com',
    androidClientId:
        '681994242014-e1ka22f7g7p63fb10dhrim96s45rds1f.apps.googleusercontent.com',
    iosClientId:
        '681994242014-vnomq6hclbalgalhk662hqj7cr1d3e8j.apps.googleusercontent.com',
    iosBundleId: 'com.newera.captainappp.RunnerTests',
  );
}
