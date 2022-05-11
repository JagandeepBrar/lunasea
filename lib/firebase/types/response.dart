import 'package:firebase_auth/firebase_auth.dart';

class LunaFirebaseResponse {
  final bool state;
  final UserCredential? user;
  final FirebaseAuthException? error;

  LunaFirebaseResponse({
    required this.state,
    this.user,
    this.error,
  });
}
