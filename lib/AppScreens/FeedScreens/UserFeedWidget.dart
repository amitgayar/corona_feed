import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/Models/CRUDModel.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:toast/toast.dart';

import '../FeedScreens/WebView.dart';
import '../../constants/constants.dart';
import 'package:modular_login/AppScreens/FeedScreens/ListTileWidgetsModel.dart';

class UserFeedWidget extends StatefulWidget {
  @override
  _UserFeedWidgetState createState() => _UserFeedWidgetState();
}

class _UserFeedWidgetState extends State<UserFeedWidget> {
  TextEditingController _urlTextController = new TextEditingController();
  FirebaseUser _currentUser;
  CRUDModel crudModel = new CRUDModel();
  bool isPosting = false;
  String url;
  final AuthService _auth = AuthService();
  bool emailVerifiedStatus = true;
  ScrollController _scrollController = ScrollController();
  Future<List> _getFeedFuture;
  bool _canLoadMorePosts = true;
  DocumentSnapshot _lastDocument;
  List feedItemList = [];

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

  postFeed(url) async {
    _currentUser = await FirebaseAuth.instance.currentUser();

    if (_currentUser.isEmailVerified) {
      if (url.isNotEmpty && checkURL(url)) {
        String responseString = await crudModel.getMetaDataFromUrl(url);

        String title = "", description = "";
        Map<String, dynamic> feedItemMap;

//        print("Respose "+ responseString);
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
        if (responseString != null && title != null && description != null) {
          crudModel.createUserFeedDocument(title, feedItemMap);
          Toast.show("Posted Successfully", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        } else
          Toast.show("This Link Can't be Posted", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      } else if (url.isNotEmpty && !checkURL(url))
        Toast.show("Invalid Link", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      else
        Toast.show("Please Enter Link to Post", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);

      setState(() {
        _urlTextController.clear();
        isPosting = false;
        list();
      });
    } else {
      setState(() {
        isPosting = false;
        _auth.sendEmailVerificationLink();
        Toast.show(
            "Email Verification Link Sent Again.\nPlease Verify your Email to Post Links in the Community",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP);
      });
    }
  }

  list() {
    print("Building List");
    return FutureBuilder(
        future: crudModel.fetchCommunityFeed(_lastDocument),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
//                print('projectSnap data is: ${projectSnap.data} ');
            return Center(child: Text("Please Share Something...."));
          }

          if (projectSnap.hasData && _canLoadMorePosts) {
            feedItemList.addAll(projectSnap.data);
            print('feedItemList data is: ${feedItemList.toString()} ');
            print("Length = ${projectSnap.data.length}");
            print("Length 2= ${feedItemList.length}");

            _lastDocument = feedItemList[feedItemList.length - 1];

            if (feedItemList.length < 10) {
              _canLoadMorePosts = false;
              _lastDocument = null;
            }
//            print('feedItemMapList $feedItemMapList');
          }
          return ListView.builder(
              itemCount: feedItemList.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
//                  print(feedItemMapList);
                final item = feedItemList[index];
//                  print("Item ${index+1} is ${item.runtimeType}");
                UrlData _urlData =
                    new UrlData(url: item['url'], title: item['title']);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Material(
                    color: Colors.white,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(7),
                    shadowColor: baseColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        isThreeLine: true,
                        title: title(item['title']),
                        subtitle: subtitle(item['description'],
                            (item['datePosted']).toDate().toString()),
                        trailing: userThumbnail(url),
                        onTap: () => Navigator.pushNamed(context, '/webView',
                            arguments: _urlData),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(controlListener);
  }


  controlListener() async {
    print("Calling Listener");
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = MediaQuery.of(context).size.height * 0.55;
    if (maxScroll - currentScroll <= delta && _canLoadMorePosts) {
      print("Calling fetchCommunity Feed");
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building Community Feed Widget");
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: list(),
          ),
        ),
        SizedBox(
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
        ),
      ],
    );
  }
}
