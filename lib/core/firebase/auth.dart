import 'package:firebase_auth/firebase_auth.dart';
import 'package:lunasea/core.dart';

class LunaFirebaseAuth {
    /// Return an instance of [FirebaseAuth].
    /// 
    /// Throws an error if [LunaFirebase.initialize] has not been called.
    static FirebaseAuth get instance => FirebaseAuth.instance;

    /// Returns the [User] object.
    /// 
    /// If the user is not signed in, returns null.
    User get user => instance.currentUser;

    /// Returns the user's UID.
    /// 
    /// If the user is not signed in, returns null.
    String get uid {
        if(instance.currentUser == null) return null;
        return instance.currentUser.uid;
    }

    /// Return the user's email.
    /// 
    /// If the user is not signed in, returns null.
    String get email {
        LunaFirebaseFirestore().getBackupList();
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
    /// Returns a [LunaFirebaseAuthResponse] which contains the state (true on success, false on failure), the [User] object, and [FirebaseAuthException] if applicable.
    Future<LunaFirebaseAuthResponse> registerUser(String email, String password) async {
        try {
            assert(email != null && password != null);
            UserCredential _user = await instance.createUserWithEmailAndPassword(email: email, password: password);
            return LunaFirebaseAuthResponse(state: true, user: _user.user, error: null);
        } on FirebaseAuthException catch (error) {
            return LunaFirebaseAuthResponse(state: false, user: null, error: error);
        } catch (error, stack) {
            LunaLogger().error("Failed to register user: $email", error, stack);
            return LunaFirebaseAuthResponse(state: false, user: null, error: null);
        }
    }

    Future<LunaFirebaseAuthResponse> signInUser(String email, String password) async {
        try {
            assert(email != null && password != null);
            UserCredential _user = await instance.signInWithEmailAndPassword(email: email, password: password);
            return LunaFirebaseAuthResponse(state: true, user: _user.user, error: null);
        } on FirebaseAuthException catch (error) {
            return LunaFirebaseAuthResponse(state: false, user: null, error: error);
        } catch (error, stack) {
            LunaLogger().error("Failed to login user: $email", error, stack);
            return LunaFirebaseAuthResponse(state: false, user: null, error: null);
        }
    }
}
