import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class LunaFirebase {
  /// Returns true if Firebase in its entirety is compatible with this build system/platform.
  static bool get isPlatformCompatible =>
      Platform.isIOS || Platform.isAndroid || Platform.isMacOS;

  /// Initialize Firebase and configuration.
  ///
  /// This must be called before anything accesses Firebase services, or an exception will be thrown.
  Future<void> initialize() async => await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
}
