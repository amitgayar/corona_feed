import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:modular_login/AppScreens/CustomWidgets/CustomDrawer.dart';
import 'package:modular_login/AppScreens/FeedScreens/FeedsWidget.dart';
import 'package:modular_login/AppScreens/FeedScreens/UserFeedWidget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<bool> onBackPressed(){
    return showDialog(
        context: context,
      builder: (context) => AlertDialog(
        title: Text("Want to Exit the App ?"),
        actions: <Widget>[
          FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("NO")),
          FlatButton(onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'), child: Text("YES"))
        ],
      )
    );
  }

  getUserNameFromLoginPage() {
    String _data;
    RouteSettings settings = ModalRoute.of(context).settings;
    _data = settings.arguments.toString();
    return _data;
  }

  getNameFromGoogleSignIn() {
    List _data = [];
    RouteSettings settings = ModalRoute.of(context).settings;
    print("Google Sign IN Name" + settings.arguments.toString());
    _data = settings.arguments;
    return _data[1];
  }

  getImageFromGoogleSignIn() {
    List _data = [];
    RouteSettings settings = ModalRoute.of(context).settings;
//    print("Google Sign IN Image" + settings.arguments.toString());
    _data = settings.arguments;
    return _data[2];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              drawer: Drawer(
                child:
                (getUserNameFromLoginPage()!=null) ?
                CustomDrawer(
                    userName: getUserNameFromLoginPage(),
                    url : "x"):
                CustomDrawer(
                    userName: getNameFromGoogleSignIn(),
                    url : getImageFromGoogleSignIn()),
              ),
              appBar: AppBar(
                title: Text("HOME"),
                bottom: TabBar(
                  tabs: [
                    Tab(text: "Feeds"),
                    Tab(text: "User Feeds")
                  ],
                ),
              ),
              body: TabBarView(
                  children: <Widget>[
                    FeedsWidget(),
                    UserFeedWidget()
                  ]
              ),
            ),
          ),
      ),
    );
  }
}