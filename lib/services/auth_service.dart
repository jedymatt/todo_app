import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get user => auth.authStateChanges();

  /// Returns as message of success or fail
  Future<String> createAccount(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Unidentified error';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Unidentified error';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Unidentified error';
    } catch (e) {
      rethrow;
    }
  }
}
