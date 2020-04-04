import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:modular_login/AppScreens/CustomWidgets/CustomDrawer.dart';
import 'package:modular_login/AppScreens/FeedScreens/FeedsWidget.dart';
import 'package:modular_login/AppScreens/FeedScreens/UserFeedWidget.dart';

class HomePage extends StatefulWidget {

  String email;

  HomePage({this.email});

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
                CustomDrawer(
                    userName: (widget.email !=null) ?
                    widget.email :
                    getUserNameFromLoginPage())
              ),
              appBar: AppBar(
                title: Text("HOME"),
                bottom: TabBar(
                  indicatorColor: Colors.pink[300],
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