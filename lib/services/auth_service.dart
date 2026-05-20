import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // REGISTER
  Future<UserCredential?> register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _auth.signOut();

      return credential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // LOGIN
  Future<UserCredential?>
      login({
    required String email,
    required String password,
  }) async {

    try {

      return await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    } on FirebaseAuthException {
      rethrow;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}