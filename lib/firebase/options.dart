import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Stub that allows building the application but with Firebase disabled.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnsupportedError('Firebase is not supported on this platform.');
  }
}
