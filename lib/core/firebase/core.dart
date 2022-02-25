import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class LunaFirebase {
  /// Initialize Firebase and configuration.
  ///
  /// This must be called before anything accesses Firebase services, or an exception will be thrown.
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
