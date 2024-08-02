import 'package:firebase_auth/firebase_auth.dart';
import 'package:hook_diner/core/locator.dart';
import 'package:hook_diner/core/models/user.dart' as user_model;
import 'package:hook_diner/core/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _databaseService = locator<DatabaseService>();

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

  Future updateUser(user_model.User user,
      {required String prevUsername, required String prevPassword}) async {
    await logOut();
    try {
      late final UserCredential? userCredential;
      switch (_auth.currentUser) {
        case null:
          userCredential = await _auth.signInWithEmailAndPassword(
              email: '$prevUsername@hookdiner.com', password: prevPassword);
          break;
        default:
          userCredential = await _auth.currentUser
              ?.reauthenticateWithCredential((EmailAuthProvider.credential(
            email: '$prevUsername@hookdiner.com',
            password: prevPassword,
          )));
      }

      await userCredential!.user!.updatePassword(user.password!);
      await userCredential.user!.reload();

      await _databaseService.updateUser(user);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteUser(user_model.User user) async {
    await logOut();
    try {
      late final UserCredential? userCredential;
      switch (_auth.currentUser) {
        case null:
          userCredential = await _auth.signInWithEmailAndPassword(
            email: '${user.username}@hookdiner.com',
            password: user.password!,
          );
          break;
        default:
          userCredential = await _auth.currentUser
              ?.reauthenticateWithCredential((EmailAuthProvider.credential(
            email: '${user.username}@hookdiner.com',
            password: user.password!,
          )));
      }

      await userCredential!.user!.delete();

      await _databaseService.deleteUser(userCredential.user!.uid);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future logOut() async {
    await _auth.signOut();
  }

  Future<User?> logIn({
    required String username,
    required String password,
  }) async {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: '$username@hookdiner.com',
      password: password,
    );
    return userCredential.user;
  }

  Future getCurrentUser() async {
    final authUser = _auth.currentUser;
    if (authUser != null) {
      user_model.User currentUser =
          await _databaseService.getUser(authUser.uid) as user_model.User;

      return currentUser;
    }
  }
}
