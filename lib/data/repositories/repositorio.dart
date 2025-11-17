import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> loginWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final result =
          await _firebaseAuth.signInWithCredential(credential);

      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> cadastro(String email, String password) async {
    final cadastro = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cadastro.user;
  }

  Future<User?> login(String email, String password) async {
    final login = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return login.user;
  }

  Future<void> logout() => _firebaseAuth.signOut();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
