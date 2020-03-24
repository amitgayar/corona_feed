import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:modular_login/AppScreens/CustomWidgets/CustomDrawer.dart';
import 'package:modular_login/AppScreens/FeedScreens/FeedsWidget.dart';
import 'package:modular_login/AppScreens/FeedScreens/UserFeedWidget.dart';

class HomePage extends StatefulWidget {

  int type;

  HomePage({
    this.type
  });

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

//  getData() async{
//    try {
//      FirebaseUser _data;
//      RouteSettings settings = ModalRoute.of(context).settings;
//      print(settings.arguments);
//      _data = settings.arguments;
////      return _data.email;
//    return "";
//    } on Exception catch (e) {
//      return "";
//    }
//  }

//  getDatafromGoogleSignIn() {
//    FirebaseUser _data;
//    RouteSettings settings = ModalRoute.of(context).settings;
//    print(settings.arguments);
//    _data = settings.arguments;
//    return _data;
//  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.blue[50],
              drawer: Drawer(
                child: CustomDrawer(userName: "UsrName"),
              ),
              appBar: AppBar(
                title: Text("HOME"),
                bottom: TabBar(
                  tabs: [
                    Tab(text: "Feeds",),
                    Tab(text: "User Feeds",)
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