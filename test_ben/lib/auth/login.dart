import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_ben/auth/phone_authentication.dart';
import 'package:test_ben/home/home.dart';
import '../common_widget/external_login_button.dart';
import 'auth_service.dart';

class Login extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
 bool _isLoading = true;

  @override
  void initState() {
    autoLogin();
    Firebase.initializeApp().whenComplete(() {
      print("+++++++++++++ completed ++++++++++++++");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading?Center(child: CircularProgressIndicator()):Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 280,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/firebase.png"),
            ),
          )),
      ExternalLoginButton(
        imagePath: "assets/images/google_icon.png",
        title: "Google",
        onTap: () {
          print("+++++++++++++++++++++++");
          _googleSignIn.signOut().then((value) {
            setState(() {});
          }).catchError((e) {});
          _googleSignIn.signIn().then((userData) {
            print(userData.email);
            signInFirebase(userData);
            setState(() {
              /*_isLoggedIn = true;
                  _userObj = userData;*/
            });
          }).catchError((e) {
            print(e);
          });
        },
        buttonColor: Colors.blue,
        textColor: Colors.white,
      ),
      ExternalLoginButton(
        imagePath: "assets/images/phone.png",
        title: "Phone",
        onTap: () async {
          phoneAuthentication();
        },
        textColor: Colors.white,
        buttonColor: Colors.green,
      ),
    ]));
  }

  signInFirebase(GoogleSignInAccount userData) async {
    print(userData.email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userData.displayName);
    prefs.setString("userId", userData.id);
    prefs.setString("profilePic", userData.photoUrl);
    final GoogleSignInAuthentication googleAuth = await userData.authentication;
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    prefs.setInt("isLoggedIn", 1);
    prefs.setBool("isMobile", false);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductListHome()));
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  phoneAuthentication() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MobileVerification()));
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int isLoggedIn = prefs.getInt('isLoggedIn');
    print(isLoggedIn);
    if (isLoggedIn != null) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProductListHome()),
          (route) => false);
    }else{
      setState(() {
        _isLoading = false;
      });
    }
  }
}
