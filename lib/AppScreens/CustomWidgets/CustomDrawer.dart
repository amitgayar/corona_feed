import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/FeedScreens/WebView.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

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
    return ListView(
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
          ListTile(
            onTap: () => {Navigator.pop(context)},
            title: Text("Home",
              style: TextStyle(
                  color: baseColor
              ),
            ),
            leading: Icon(Icons.home,color: Colors.indigo[900]),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/Myfeeds');
            },
            title: Text("My Feeds",
              style: TextStyle(
                  color: baseColor
              ),
            ),
            leading: Icon(Icons.rss_feed,color: Colors.indigo[900],),
          ),
          ListTile(
            onTap: (() {
              UrlData _urlData = new UrlData(url: LiveWorldStatsUrl, title: "Live World Stats");
              Navigator.pop(context);
              Navigator.pushNamed(context, '/customWebView', arguments: _urlData);
            }),
            title: Text("Live World Stats",
              style: TextStyle(
                  color: baseColor
              ),
            ),
            leading: ImageIcon(AssetImage("assets/worldStatsIcon.png"),color: Colors.indigo[900]),
          ),
          ListTile(
            onTap: (() {
              UrlData _urlData = new UrlData(url: whoQnaUrl, title: "WHO Q&A");
              Navigator.pop(context);
              Navigator.pushNamed(context, '/webView', arguments: _urlData);
            }),
            title: Text("WHO - Q&A",
              style: TextStyle(
                  color: baseColor
              ),
            ),
            leading: ImageIcon(AssetImage("assets/who.png"),color: Colors.indigo[900]),
          ),
          ListTile(
            onTap: (() {
              UrlData _urlData = new UrlData(url: chatUrl , title: "Chat : Send News links to get fact checked");
              Navigator.pop(context);
              Navigator.pushNamed(context, '/webView', arguments: _urlData);
            }),
            title: Text("Chat",
              style: TextStyle(
                  color: baseColor
              ),
            ),
            subtitle: Text("Send News links to get fact checked",
              style: TextStyle(
                  color: baseColor
              ),
            ),
            leading: Icon(Icons.question_answer,color: Colors.indigo[900]),
          ),
          ListTile(
            onTap: () => { signOut()},
            title: Text("Log Out",
              style: TextStyle(
                  color: baseColor
              ),
            ),
            leading: Icon(Icons.power_settings_new,color: Colors.indigo[900]),
          ),
        ],
      );
  }
}