import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User _currentUser;
  User get currentUser => _currentUser;

  Future signUp({
    required String username,
    required String password,
  }) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: '$username@hookdiner.com',
      password: password,
    );

    return user.additionalUserInfo?.isNewUser;
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
