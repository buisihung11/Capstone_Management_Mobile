import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_demo/utils/index.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  // final request = MyRequest();

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return _firebaseAuth.currentUser();
    } catch (err) {
      print('Error Login: $err');
      throw (err);
    }
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    // check if has token and valid token
    try {
      final jwtToken = await getToken();
      if (jwtToken != null) {
        // TODO: set request jwt
        requestObj.setToken = jwtToken;
        final res = await request
            .get("/user-info", queryParameters: {"token": jwtToken});
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<dynamic> getUser() async {
    // check token
    try {
      final jwtToken = await getToken();
      if (jwtToken == null) {
        return null;
      }
      // set token to request
      requestObj.setToken = jwtToken;
      return request.get("/user-info", queryParameters: {"token": jwtToken});
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // loginToServer
  Future<dynamic> loginWithServer(firebaseToken) {
    return request.get(
      "/login-by-google",
      queryParameters: {
        "token": firebaseToken,
      },
    );
  }

  Future<dynamic> saveFCMToken(fcmToken) {
    return request.post(
      "/users/tokens",
      data: {
        "fcmToken": fcmToken,
      },
    );
  }
}
