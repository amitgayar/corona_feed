import 'package:flutter/material.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'CountWidget.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {

  String userName;

  CustomDrawer({
    this.userName,
  });


  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final AuthService _auth = AuthService();

  signOut() async{
    await _auth.signOut();
    signOutGoogle();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");

    Toast.show("Log Out Successfull",context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.popAndPushNamed(context, '/Login');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,15,10,10),
      child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget> [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Image.asset("assets/photoNotAvailaible.png")
                  ),
                  Container(height: 15),
                  Text(
                    widget.userName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () => {Navigator.pop(context)},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home,color: Colors.indigo[900]),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => {Navigator.pushNamed(context, '/Myfeeds')},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.rss_feed,color: Colors.indigo[900],),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "My Feeds",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: CountWidget()
            ),//MyFeeds
            InkWell(
              onTap: () => { signOut()},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.power_settings_new,color: Colors.indigo[900]),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}