import 'package:firebase_auth/firebase_auth.dart';

final AuthService authService = AuthService();

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool authenticate() {
    if (_auth.currentUser != null) {
      return true;
    }
    return false;
  }

  Future<String> login(
      {required String email, required String password}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return response.user!.uid;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<String> register(
      {required String email, required String password}) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return response.user!.uid ?? "";
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future logout() async {
    await _auth.signOut();
  }
}
