import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:msbazaar/utils/another_flushbar.dart';

class GoogleSignUtils {
  Future<UserCredential?> signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      AnotherFlushbar.anotherFlushbar(context, e.toString());
    }
    return null;
  }

  Future signOutGoogle(context) async {
    try{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    }catch(e){
      AnotherFlushbar.anotherFlushbar(context, e.toString());
    }
  }
}
