import 'package:firebase_auth/firebase_auth.dart';
import '../Models/UserModel.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create User Object from Firebase UserId
  User _userFromFirebaseUser(FirebaseUser user) {
    if(user != null)
      return User(uid: user.uid);
    else
      return null;
  }

  //Register the User with Email and Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      user.sendEmailVerification();
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if(user.isEmailVerified)
        return user;
      else
        return;
    } catch (error) {
      print("Firebase File: " + error.toString());
      return error.toString();
    }
  }

  //Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}