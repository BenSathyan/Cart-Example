import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_ben/auth/login.dart';

// ignore: must_be_immutable
class NavigationDrawer extends StatelessWidget {
  String name;
  String profilePic;
  String id;
  String phone;
  NavigationDrawer(this.name, this.profilePic, this.id, this.phone);

  @override
  Widget build(BuildContext context) {
    print("++++++++++++ Drawer ++++++++++");
    print(phone);
    print(profilePic);
    print(id);
    print(profilePic);
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(76, 176, 80, 1),
                Color.fromRGBO(124, 215, 86, 1),
              ]),
            ),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  CircleAvatar(
                    child: ClipOval(
                      child: Image.network(profilePic,
                          width: 120, fit: BoxFit.fill),
                    ),
                    radius: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      name.length != 0 ? name : phone,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Text(
                    "Id: " + id,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              logout(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.black45,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text("Log Out",
                        style: TextStyle(
                          color: Colors.black45,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

   logout(BuildContext context) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setInt("isLoggedIn", 0);
     prefs.clear();
     Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
             builder: (BuildContext context) => Login()),
             (route) => false);
   }
}
