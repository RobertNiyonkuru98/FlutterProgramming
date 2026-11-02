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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
  
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoPlaceholderApiKeyForWeb123456789',
    appId: '1:123456789012:web:demo123456789',
    messagingSenderId: '123456789012',
    projectId: 'demo-todo-app',
  );
  
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCm_uF-OL9DeBGpK4cqAyA9uZVp5xzoQ48',
    appId: '1:186440658171:android:46c534e5b2e5314adf545e',
    messagingSenderId: '123456789012',
    projectId: 'alu-todo-app',
  );
  
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoPlaceholderApiKeyForIos123456789',
    appId: '1:123456789012:ios:demo123456789',
    messagingSenderId: '123456789012',
    projectId: 'demo-todo-app',
    iosBundleId: 'com.example.testConnection',
  );
}
