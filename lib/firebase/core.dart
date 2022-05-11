import 'package:firebase_core/firebase_core.dart';
import 'package:lunasea/system/platform.dart';

// ignore: always_use_package_imports
import 'options.dart';

class LunaFirebase {
  static bool get isSupported {
    final platform = LunaPlatform();
    if (platform.isMobile || platform.isMacOS || platform.isWeb) {
      // Validate that the firebase config exists by trying to load it
      try {
        DefaultFirebaseOptions.currentPlatform;
        return true;
        // ignore: empty_catches
      } catch (_) {}
    }
    return false;
  }

  /// Initialize Firebase and configuration.
  ///
  /// This must be called before anything accesses Firebase services, or an exception will be thrown.
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
