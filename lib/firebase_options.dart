import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // 다른 플랫폼에 대한 옵션은 생략
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyApslIG9rTDjL-XNI71aqUTfNjXGfu_Gks',
    appId: '1:216581974180:web:be3c88bd20a28907761e31',
    messagingSenderId: '216581974180',
    projectId: 'faber-ticket-ft',
    authDomain: 'faber-ticket-ft.firebaseapp.com',
    storageBucket: 'faber-ticket-ft.firebasestorage.app',
  );
}
