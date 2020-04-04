import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:toast/toast.dart';

import 'CountWidget.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {

  String userName;
  String url;

  CustomDrawer({
    this.userName,
    this.url,
  });


  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final AuthService _auth = AuthService();
  FirebaseUser _currentUser ;

  getCurrentUserEmail() async {
    _currentUser = await FirebaseAuth.instance.currentUser();
    return _currentUser.email;
  }

  signOut() async{
    await _auth.signOut();
    signOutGoogle();
    Toast.show("Log Out Successfull",context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.popAndPushNamed(context, '/Login');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,15,10,10),
      child: ListView(
          children: <Widget>[
            Column(
              children: <Widget> [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child:
                    (!widget.url.contains("googleusercontent")) ?
                    Image.asset("assets/photoNotAvailaible.png"):
                    Image.network(widget.url),
                ),
                Container(height: 25),
                Text(
                  widget.userName.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            Divider(
              thickness: 5,
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