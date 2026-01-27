import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>> continueWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final Map<String, dynamic> data = await FacebookAuth.instance.getUserData();
    //{name: Oubeid Zouabi, email: contact@oubeid.com, picture: {data: {height: 199, is_silhouette: false,
    //url: https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3594038130865635&width=200&ext=1697759880&hash=AeS3oc_QlT2U9bDA5F0, width: 200}}
    // , id: 3594038130865635}

    FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    return data;
  }

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String> getCurrentUserId() async {
    return _auth.currentUser!.uid;
  }

  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() async {
    await _auth.signOut();
    // await _googleSignIn.signOut();
  }
}
