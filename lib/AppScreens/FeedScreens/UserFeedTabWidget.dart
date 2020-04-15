import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/Models/CRUDModel.dart';
import 'package:modular_login/Models/UrlDataModel.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
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

//  getCurrentUserImage() async {
//    url = await FirebaseAuth.instance.currentUser().then((_currentUser) {
//      return _currentUser.photoUrl;
//    }).catchError((onError) {
//      print("IN CRUD MODEL ERROR photo Fetch : " + onError.toString());
//    });
//  }

  getCurrentUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameText = prefs.get('email');
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
    getCurrentUserName();
  }

  list() {
    print("Buidling List");
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
                itemCount: snapshot.data.documents.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0){
                    return Center(child: Image.asset("assets/userFeed.gif"));
                  }else{
                    final item = snapshot.data.documents[index-1];
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor:
                                (nameText == item['postedBy']) ? baseColor : Colors.blue,
                                child:
                                Text(
                                  (item['postedBy'] == nameText) ? "ME" : item['postedBy'].toUpperCase().substring(0,1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )
                              ),
                            ],
                          ),
                          onTap: () => Navigator.pushNamed(context, '/webView', arguments: _urlData),
                        ),
                      ),
                    );
                  }
            });
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
          children: <Widget>[
            list(),
            Align(
              alignment : Alignment.bottomRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: AnimatedCrossFade(
                          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                          sizeCurve: Curves.linear,
                          firstChild: Container(),
                          secondChild: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Link to Post",
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: baseColor),
                                    borderRadius: BorderRadius.circular(7)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: baseColor),
                                    borderRadius: BorderRadius.circular(7)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: baseColor),
                                    borderRadius: BorderRadius.circular(7)
                                ),
                              ),
                              keyboardType: TextInputType.url,
                              controller: _urlTextController,
                            ),
                          ),
                          crossFadeState: showPost ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 500)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: baseColor,
                      ),
                      child: InkWell(
                        onTap: () {
                          if(showPost){
                            showPost = !showPost;
                            postFeed(_urlTextController.text);
                          } else {
                            showPost = !showPost;
                          }
                          setState(() {});
                          },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            child:!showPost ?
                            Icon(Icons.add,color: Colors.white,) :
                            Icon(Icons.send, color: Colors.white,)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}