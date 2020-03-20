import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  int userCount = 15;
  int communityCount = 100;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: DrawerHeader(
                decoration: BoxDecoration(
//                  gradient: LinearGradient(begin: Alignment.bottomLeft,colors: <Color>[
//                    Colors.blue[600],
//                    Colors.blue[300],
//                    Colors.blue[100]
//                  ])
                gradient: RadialGradient(
                    radius: 1,
                    colors: <Color>[
                      Colors.blue[100],
                      Colors.blue[300],
                      Colors.blue[600],
                    ])
                ),
                child: Column(
                  children: <Widget> [
                    Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/icon.png"),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "User Name",
                      style: TextStyle(
                          fontSize: 30
                      ),)
                    ],
                )),
          ),
          InkWell(
            onTap: () => {},
            splashColor: Colors.grey[500],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                        child: Text(
                          userCount.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getSize(),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.blue[700],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Community Feed Count : "+ communityCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      );
  }

  double getSize() {
    if(userCount/100 > 100)
      return 9.0;
    else if(userCount/10 > 10)
      return 12.0;
    else
      return 18.0;
  }
}
