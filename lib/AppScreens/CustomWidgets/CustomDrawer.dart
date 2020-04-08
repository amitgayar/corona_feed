import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/FeedScreens/WebView.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'customWebView.dart';

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

    Toast.show("Log Out Successfull",context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    Navigator.pushReplacementNamed(context, '/Login');
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => {Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => CustomWebView(url : LiveWorldStatsUrl))
              )},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.rss_feed,color: Colors.indigo[900],),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "My Feeds",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (() {
                  UrlData _urlData = new UrlData(url: LiveWorldStatsUrl, title: "Live World Stats");
                  Navigator.pushNamed(context, '/webView', arguments: _urlData);
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ImageIcon(AssetImage("assets/worldStatsIcon.png"),color: Colors.indigo[900]),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Live World Stats",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (() {
                UrlData _urlData = new UrlData(url: whoQnaUrl, title: "WHO Q&A");
                Navigator.pushNamed(context, '/webView', arguments: _urlData);
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ImageIcon(AssetImage("assets/who.png"),color: Colors.indigo[900]),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "WHO - Q&A",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (() {
                UrlData _urlData = new UrlData(url: chatUrl , title: "Chat");
                Navigator.pushNamed(context, '/webView', arguments: _urlData);
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.question_answer,color: Colors.indigo[900]),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Chat",
                      ),
                    ),
                  ],
                ),
              ),
            ),
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