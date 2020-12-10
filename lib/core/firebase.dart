import 'package:firebase_core/firebase_core.dart';

class LunaFirebase {
    LunaFirebase._();

    static Future<FirebaseApp> initialize() async => Firebase.initializeApp();
}
