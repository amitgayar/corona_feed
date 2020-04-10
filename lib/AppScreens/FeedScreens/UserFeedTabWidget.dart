import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/Models/CRUDModel.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:toast/toast.dart';

import '../FeedScreens/WebView.dart';
import '../../constants/constants.dart';
import 'package:modular_login/AppScreens/FeedScreens/ListTileWidgetsModel.dart';

class UserFeedTabWidget extends StatefulWidget {
  @override
  _UserFeedTabWidgetState createState() => _UserFeedTabWidgetState();
}

class _UserFeedTabWidgetState extends State<UserFeedTabWidget> {
  TextEditingController _urlTextController = new TextEditingController();
  FirebaseUser _currentUser;
  final AuthService _auth = AuthService();
  CRUDModel crudModel = new CRUDModel();
  bool isPosting = false;
  String url;
  bool emailVerifiedStatus = true;
  List feedItemList = [];
  bool isLoading=true;
  bool showPost = false;
  String nameText="";


  extractTitle(response) {
    String extractedTitle;
    if (response.contains("<title>") && response.contains("</title>"))
      extractedTitle = response.substring(
          response.indexOf("<title>"), response.indexOf("</title>"));

    if (extractedTitle != null)
      return extractedTitle.substring(7, extractedTitle.length);
    else
      return null;
  }

  extractDescription(response) {
    String extractedDescription =
        (response.indexOf("name=\"description\" content=\"") != 1)
            ? null
            : response.substring(
                response.indexOf("name=\"description\" content=\""), 20);
    if (extractedDescription != null) {
      return extractedDescription.substring(32, extractedDescription.length);
    } else
      return "Tap for Details";
  }

  getCurrentUserImage() async {
    url = await FirebaseAuth.instance.currentUser().then((_currentUser) {
      return _currentUser.photoUrl;
    }).catchError((onError) {
      print("IN CRUD MODEL ERROR photo Fetch : " + onError.toString());
    });
  }

  getCurrentUserName() async {
    nameText = await FirebaseAuth.instance.currentUser().then((_currentUser) {
      return _currentUser.email;
    }).catchError((onError) {
      print("IN CRUD MODEL ERROR name Fetch : " + onError.toString());
    });
  }

  postFeed(url) async   {
    _currentUser = await FirebaseAuth.instance.currentUser();

    if (_currentUser.isEmailVerified) {
      if (url.isNotEmpty && checkURL(url)) {
        String responseString = await crudModel.getMetaDataFromUrl(url);

        String title = "", description = "";
        Map<String, dynamic> feedItemMap;

//        print("Response "+ responseString);
        print("URL Posted is " + url);

        if (responseString != null) {
          title = extractTitle(responseString);
          String description = extractDescription(responseString);
          feedItemMap = {
            'title': title,
            'description': description,
            'url': url,
            'datePosted': DateTime.now(),
            'postedBy': _currentUser.email,
            'commentsList': [
              {'comment': null, 'commentBy': null, 'DateTimeStamp': null}
            ]
          };
        }
        if( responseString != null && title!=null && description!=null ) {
          var state = await crudModel.createUserFeedDocument(title, feedItemMap);
//          print("State in userFeed : $state");
          if (state != null) {
            Toast.show("Posted Successfully", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          }else{
            Toast.show("The Link is Already Posted", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          }
        }else
          Toast.show("This Link Can't be Posted", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }else if(url.isNotEmpty && !checkURL(url))
        Toast.show("Invalid Link", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      else
        Toast.show("Please Enter Link to Post", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);

      setState(() {
        _urlTextController.clear();
        isPosting = false;
        showPost = false;
      });
    } else {
      setState(() {
        isPosting = false;
        _auth.sendEmailVerificationLink();
        Toast.show("Email Verification Link Sent Again.\nPlease Verify your Email to Post Links in the Community", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserImage();
    getCurrentUserName();
  }

  list() {
    return StreamBuilder(
        stream: Firestore.instance.collection("CommunityFeed").orderBy("datePosted",descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Image.asset("assets/washed_away_covid-19.gif"))
            );
          else if (snapshot.data.documents.length == 0){
            print("length : ${snapshot.data.documents.length }");
            return Image.asset("assets/no item to display.gif");
          } else
            return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data.documents[index];
//                 print("Item ${index+1} is ${item.runtimeType}");
              UrlData _urlData = new UrlData(url: item['url'], title: item['title']);
              return Padding(
                padding: const EdgeInsets.fromLTRB(10,10, 10, 0),
                child: Material(
                  color: Colors.white,
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(7),
                  shadowColor: baseColor,
                  child: ListTile(
                    isThreeLine: true,
                    title: title(item['title']),
                    subtitle: twoItemSubtitle(item['description'],(item['datePosted']).toDate().toString().substring(0,16)),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: baseColor,
                          child:
                          (url==null) ?
                          Text(
                              (nameText == item['postedBy']) ? "ME" : item['postedBy'].toUpperCase().substring(0,1),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ) :
                          Image.network(url),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(context, '/webView', arguments: _urlData),
                  ),
                ),
              );
            });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      (!showPost) ? FloatingActionButton(
        onPressed: () {
          showPost = true;
          setState(() {});
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: baseColor,
      ) : Container(),
      body: Column(
        children: <Widget>[
          Center(child: Image.asset("assets/userFeed.gif")),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: list(),
            ),
          ),
          (showPost) ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Link to Post",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black26),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: baseColor),
                          borderRadius: BorderRadius.circular(7)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: baseColor),
                          borderRadius: BorderRadius.circular(7)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: baseColor),
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    keyboardType: TextInputType.url,
                    controller: _urlTextController,
                  ),
                ),
                (isPosting)
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    backgroundColor: baseColor,
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          color: baseColor,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isPosting = true;
                              postFeed(_urlTextController.text);
                            });
                          }),
                    ),
                  ),
                )
              ],
            ),
          ) : Container(),
        ],
      ),
    );
  }
}