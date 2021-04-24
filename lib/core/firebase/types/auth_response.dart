import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LunaFirebaseAuthResponse {
  final bool state;
  final User user;
  final FirebaseAuthException error;

  LunaFirebaseAuthResponse({
    @required this.state,
    @required this.user,
    @required this.error,
  });
}
