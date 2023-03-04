import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steemit/core/exception/exception.dart';
import 'package:steemit/core/failures/login_failures.dart';

final AuthService authService = AuthService();

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Either<Exception, bool> authenticate() {
    try {
      if (_auth.currentUser != null) {
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerException());
      }
      if (e is AuthorizationException) {
        return Left(AuthorizationException());
      }
      return Left(DataParsingException());
    }
  }

  Future<Either<AuthenticationFailures, String>> login(
      {required String email, required String password}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(response.user!.uid);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailures());
      }
      if (e is AuthorizationException) {
        return Left(WrongLoginInfoFailures());
      }
      return Left(DataParsingFailures());
    }
  }
}
