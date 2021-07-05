import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Auth {
  FirebaseAuth auth, authFb;
  Auth({this.auth, this.authFb});
  String fcmToken,updateStatus;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Stream<User> get user => auth.authStateChanges();
  Stream<User> get userFb => authFb.authStateChanges();

  ///For google sign in

  Future<String> signInWithGoogle() async {
    try {
      await _firebaseMessaging.getToken().then((value) => fcmToken = value);
      // Trigger the authentication flow
      await GoogleSignIn().signOut();
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      String idToken = await FirebaseAuth.instance.currentUser.getIdToken();
      if (googleUser != null) {
        if (user == "no user found") {
          print("No user found");
        }
      }
      String status = "Success";
      return status.trim();
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
  // ignore: missing_return
}
