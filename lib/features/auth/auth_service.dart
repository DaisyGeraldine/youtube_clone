import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authServiceProvider = Provider((ref) => AuthService(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn(),
    ));

class AuthService {
  FirebaseAuth firebaseAuth;
  GoogleSignIn googleSignIn;
  AuthService({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userSignIn = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuth = await userSignIn!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      final UserCredential userCredential = await firebaseAuth.signInWithCredential(authCredential);
      // return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}