/**
 * Created by Mahmud Ahsan
 * https://github.com/mahmudahsan
 */
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Map<String, String> exposeUser({@required kUsername, @required kUID}) {
  return {
    kUsername: kUsername,
    kUID: kUID,
  };
}

Future<Map<String, String>> getCurrentUser() async {
  final User user = _auth.currentUser;
  if (user != null) {
    return exposeUser(kUsername: user.displayName, kUID: user.uid);
  }
  return null;
}

Future<bool> isUserSignedIn() async {
  final User currentUser = _auth.currentUser;
  return currentUser != null;
}

void signOut() {
  try {
    _auth.signOut();
  } catch (error) {
    print(error);
  }
}


void onAuthenticationChange(Function isLogin) {
  _auth.authStateChanges().listen((User user) {
    if (user != null) {
      isLogin(exposeUser(kUsername: user.displayName, kUID: user.uid));
    } else {
      isLogin(null);
    }
  });
}

Future<Map<String, String>> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final User user = (await _auth.signInWithCredential(credential)).user;

  if (user != null) {
    return exposeUser(kUsername: user.displayName, kUID: user.uid);
  }
  return null;
}

Future<Map<String, String>> signInAnonymously() async {
  final User user = (await _auth.signInAnonymously()).user;

  if (user != null) {
    return exposeUser(kUsername: '', kUID: user.uid);
  }
  return null;
}