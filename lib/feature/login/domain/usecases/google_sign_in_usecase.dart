import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUseCase {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  GoogleSignInUseCase({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
      : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    //Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    //Once signed in, return the UserCredential
    final userCredential = await _auth.signInWithCredential(credential);

    return userCredential;
  }
}
