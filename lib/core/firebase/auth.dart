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
  User? get user => instance.currentUser;

  /// Returns if a user is signed in.
  bool get isSignedIn => instance.currentUser != null;

  /// Returns the user's UID.
  ///
  /// If the user is not signed in, returns null.
  String? get uid => instance.currentUser?.uid;

  /// Return the user's email.
  ///
  /// If the user is not signed in, returns null.
  String? get email => instance.currentUser?.email;

  /// Sign out a logged in user.
  ///
  /// If the user is not signed in, this is a non-op.
  Future<void> signOut() async => instance.signOut();

  /// Register a new user using Firebase Authentication.
  ///
  /// Returns a [LunaFirebaseResponse] which contains the state (true on success, false on failure), the [User] object, and [FirebaseAuthException] if applicable.
  Future<LunaFirebaseResponse> registerUser(
      String email, String password) async {
    try {
      UserCredential _user = await instance.createUserWithEmailAndPassword(
          email: email, password: password);
      LunaFirebaseFirestore().addDeviceToken();
      return LunaFirebaseResponse(state: true, user: _user);
    } on FirebaseAuthException catch (error) {
      return LunaFirebaseResponse(state: false, error: error);
    } catch (error, stack) {
      LunaLogger().error("Failed to register user: $email", error, stack);
      return LunaFirebaseResponse(state: false);
    }
  }

  /// Sign in a user using Firebase Authentication.
  ///
  /// Returns a [LunaFirebaseResponse] which contains the state (true on success, false on failure), the [User] object, and [FirebaseAuthException] if applicable.
  Future<LunaFirebaseResponse> signInUser(String email, String password) async {
    try {
      UserCredential _user = await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      LunaFirebaseFirestore().addDeviceToken();
      return LunaFirebaseResponse(state: true, user: _user);
    } on FirebaseAuthException catch (error) {
      return LunaFirebaseResponse(state: false, error: error);
    } catch (error, stack) {
      LunaLogger().error("Failed to login user: $email", error, stack);
      return LunaFirebaseResponse(state: false);
    }
  }

  /// Delete the currently logged in user from the Firebase project.
  ///
  /// The user's password is required to validate and acquire fresh credentials to process the deletion.
  Future<LunaFirebaseResponse> deleteUser(String password) async {
    try {
      return await user!
          .reauthenticateWithCredential(EmailAuthProvider.credential(
            email: email!,
            password: password,
          ))
          .then((credentials) => credentials.user!.delete())
          .then((_) => LunaFirebaseResponse(state: true));
    } on FirebaseAuthException catch (error) {
      return LunaFirebaseResponse(state: false, error: error);
    } catch (error, stack) {
      LunaLogger().error('Failed to delete user: ${user!.email}', error, stack);
      rethrow;
    }
  }

  /// Reset a user's password by sending them a password reset email.
  Future<void> resetPassword(String email) async {
    instance.sendPasswordResetEmail(email: email);
  }
}
