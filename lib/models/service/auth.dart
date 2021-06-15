import 'package:firebase_auth/firebase_auth.dart';
import 'package:dsixv02app/models/dsix/dsixUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// create user object based on Firebase user

  DsixUser _userFromFirebaseUser(User user) {
    return user != null ? DsixUser(uid: user.uid) : null;
  }

// auth change user stream

  Stream<DsixUser> get user {
//Map user to DsixUser
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

//Sign in Anoun

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Register with e-mail Password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign in with e-mail and Password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
