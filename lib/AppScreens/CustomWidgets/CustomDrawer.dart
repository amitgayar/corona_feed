import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/Models/CRUDModel.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:modular_login/constants/globals.dart';
import 'package:toast/toast.dart';

import 'CountWidget.dart';

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

  int userCount = myFeedCount;
  int communityCount = communityFeedCount;

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
  void initState() {
    super.initState();
    CRUDModel crudModel = new CRUDModel();
    if(userCount == 0) crudModel.fetchUserFeed();
    if(communityCount == 0) crudModel.fetchCommunityFeed();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: <Widget> [
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: (!widget.url.contains("googleusercontent")) ?
                  Image.asset("assets/photoNotAvailaible.png"):
                  Image.network(
                    widget.url,
                    width: 150,
                    height: 150
                  )
                ),
                SizedBox(height: 25),
                Text(
                  widget.userName.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                )
                ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,0),
            child: Divider(
              thickness: 5,
            ),
          ),
          InkWell(
            onTap: () => {Navigator.popAndPushNamed(context, '/Myfeeds',arguments: getCurrentUserEmail())},
            splashColor: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15,5,15,5),
              child: Row(
                children: <Widget>[
                  Icon(Icons.rss_feed,size:30),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "My Feeds",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left :60.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 75,
                      height:35,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        shape: BoxShape.circle,
                      ),
                      child: (userCount!=0)?
                      Text(
                        userCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getSize(),
                          ),
                        ) :
                      Container(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(strokeWidth: 2 )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),  //MyFeeds
          InkWell(
            onTap: () => { signOut()},
            splashColor: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15,8,15,8),
              child: Row(
                children: <Widget>[
                  Icon(Icons.power_settings_new,size:30),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              child: CountWidget()
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.blue[700],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total Community Feeds : ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                (communityCount != 0 ) ?
                Padding(
                  padding: const EdgeInsets.only(left : 15.0),
                  child: Text(
                      communityCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                ):
                Container(
                  padding: EdgeInsets.only(left: 15),
                    width: 30,
                    child: LinearProgressIndicator())
                ],
              ),
            ),
          ),
        ],
      );
  }

  double getSize() {
    if(userCount/100 > 100) return 9.0;
    else if(userCount/10 > 10) return 12.0;
    else return 18.0;
  }
}