import 'package:firebase_auth/firebase_auth.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/user.dart' as user_model;
import 'package:hook_diner/core/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _databaseService = locator<DatabaseService>();

  // late User _currentUser;
  // User get currentUser => _currentUser;

  Future createUser({
    required String username,
    required String password,
    required String role,
  }) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: '$username@hookdiner.com',
      password: password,
    );

    await _databaseService.addUser(user_model.User(
      id: user.user!.uid,
      username: username,
      password: password,
      role: role,
    ));

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
