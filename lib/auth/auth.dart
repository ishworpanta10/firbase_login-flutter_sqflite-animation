import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmail(String email, String password);
  Future<String> createUser(String email, String password);
  Future<String> getCurrentUser();
  Future<void> logOut();
}

class Auth implements BaseAuth {
  final _auth = FirebaseAuth.instance;

  Future<String> signInWithEmail(String email, String password) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> createUser(String email, String password) async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  Future<void> logOut() {
    return _auth.signOut();
  }
}
