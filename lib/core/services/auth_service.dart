import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp({
    required String username,
    required String password,
  }) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: '$username@hookdiner.com',
        password: password,
      );

      return user.additionalUserInfo?.isNewUser;
    } catch (e) {
      return e.toString();
    }
  }

  Future<User?> logIn({
    required String username,
    required String password,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: '$username@hookdiner.com',
      password: password,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }
}
