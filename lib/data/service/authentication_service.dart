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
    } on FirebaseException {
      rethrow;
    }
  }

  Future<String> register(
      {required String email, required String password}) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return response.user!.uid;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future logout() async {
    await _auth.signOut();
  }

  String getUserId() {
    return _auth.currentUser!.uid;
  }
}
