import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseAuth {
    /// Return an instance of [FirebaseAuth].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseAuth get instance => FirebaseAuth.instance;

    /// Returns the user's UID.
    /// 
    /// If the user is not signed in, returns null.
    String getUid() {
        if(instance.currentUser == null) return null;
        return instance.currentUser.uid;
    }

    /// Return the user's email.
    /// 
    /// If the user is not signed in, returns null.
    String getEmail() {
        if(instance.currentUser == null) return null;
        return instance.currentUser.email;
    }

    /// Sign out a logged in user.
    /// 
    /// If the user is not signed in, this is a non-op.
    Future<void> signOut() async {
        if(instance.currentUser == null) return;
        instance.signOut();
    }

    /// Register a new user using Firebase Authentication.
    /// 
    /// Returns a [_LunaFirebaseAuthResponse] which contains the state (true on success, false on failure), the [User] object, and [FirebaseAuthException] if applicable.
    Future<_LunaFirebaseAuthResponse> registerUser(String email, String password) async {
        try {
            assert(email != null && password != null);
            UserCredential _user = await instance.createUserWithEmailAndPassword(email: email, password: password);
            return _LunaFirebaseAuthResponse(state: true, user: _user.user, error: null);
        } on FirebaseAuthException catch (error) {
            return _LunaFirebaseAuthResponse(state: false, user: null, error: error);
        } catch (error, stack) {
            LunaLogger().error("Failed to register user: $email", error, stack);
            return _LunaFirebaseAuthResponse(state: false, user: null, error: null);
        }
    }

    Future<_LunaFirebaseAuthResponse> signInUser(String email, String password) async {
        try {
            assert(email != null && password != null);
            UserCredential _user = await instance.signInWithEmailAndPassword(email: email, password: password);
            return _LunaFirebaseAuthResponse(state: true, user: _user.user, error: null);
        } on FirebaseAuthException catch (error) {
            return _LunaFirebaseAuthResponse(state: false, user: null, error: error);
        } catch (error, stack) {
            LunaLogger().error("Failed to login user: $email", error, stack);
            return _LunaFirebaseAuthResponse(state: false, user: null, error: null);
        }
    }
}

class _LunaFirebaseAuthResponse {
    final bool state;
    final User user;
    final FirebaseAuthException error;

    _LunaFirebaseAuthResponse({
        @required this.state,
        @required this.user,
        @required this.error,
    });
}
