import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/Models/CRUDModel.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:toast/toast.dart';

import '../FeedScreens/WebView.dart';
import '../../constants/constants.dart';
import '../../Models/ListTileWidgetsModel.dart';

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

  extractTitle(response){
    String extractedTitle = response.substring(response.indexOf("<title>"),response.indexOf("</title>"));
    if(extractedTitle != null){
      return extractedTitle.substring(7,extractedTitle.length);
    }else
      return null;
  }

  extractDescription(response){
    String extractedDescription = (response.indexOf("name=\"description\" content=\"")!=1)?
          null: response.substring(response.indexOf("name=\"description\" content=\""),20);
    if(extractedDescription != null){
      return extractedDescription.substring(32,extractedDescription.length);
    }else
      return "Tap for Details";
  }

  getCurrentUserImage() async {
    url =  await FirebaseAuth.instance.currentUser()
        .then((_currentUser) {
          return _currentUser.photoUrl;
        }).catchError((onError){
          print("IN CRUD MODEL ERROR photo Fetch : " + onError.toString());
        });
  }

  postFeed(url) async {
    _currentUser = await FirebaseAuth.instance.currentUser();

    if (_currentUser.isEmailVerified) {
      if (url.isNotEmpty && checkURL(url)) {
        String responseString = await crudModel.getMetaDataFromUrl(url);

        String title ="",description = "";
        Map feedItemMap;

        if (responseString!=null) {
          title = extractTitle(responseString);
          String description = extractDescription(responseString);
          feedItemMap = {
            'title': title,
            'description': description,
            'url':url,
            'datePosted':DateTime.now().toString().substring(0,11),
            'postedBy':_currentUser.email,
            'commentsList':[{'comment':null, 'commentBy':null, 'DateTimeStamp':null}]
          };
        }

//        print("Respose "+ responseString);
        print("URL Posted is " + url);

        if( responseString != null && title!=null && description!=null ) {
          crudModel.createUserFeedDocument(_currentUser.email, feedItemMap);
          Toast.show("Posted Successfully", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
          setState(() {build(context);});
        }else
          Toast.show("This Link Can't be Posted", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }else if(url.isNotEmpty && !checkURL(url))
        Toast.show("Invalid Link", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      else
        Toast.show("Please Enter Link to Post", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);

      setState(() {
        _urlTextController.clear();
        isPosting = false;
      });

    } else {
      setState(() {
        isPosting = false;
        _auth.sendEmailVerificationLink();
        Toast.show("Email Verification Link Sent Again.\nPlease Verify your Email to Post Links in the Community",
            context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      });
    }
  }

  list() {
    return FutureBuilder(
        future: crudModel.fetchCommunityFeed(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
//                print('projectSnap data is: ${projectSnap.data} ');
            return Center(child: Text("Please Share Something...."));
          }

          if(projectSnap.hasData){
//            print('projectSnap data is: ${projectSnap.data} ');
            List feedItemList = projectSnap.data;
            feedItemList.sort((a,b) => b['datePosted'].compareTo(a['datePosted']));
//            print('feedItemMapList $feedItemMapList');

            return ListView.builder(
                itemCount: feedItemList.length,
                itemBuilder: (BuildContext context, int index) {
//                  print(feedItemMapList);
                  final item = feedItemList[index];

//                  print("Item ${index+1} is ${item.runtimeType}");

                  UrlData _urlData = new UrlData(url: item['url'], title: item['title']);
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            isThreeLine: true,
                            title: title(item['title']),
                            subtitle: subtitle(item['description'], item['datePosted']),
                            trailing: userThumbnail(url),
                            contentPadding: EdgeInsets.all(5.0),
                            onTap: () =>
                                Navigator.pushNamed(context, '/webView', arguments: _urlData),
                          ),
                        ),
                      ),
                    );
              }
            );
          } else if(projectSnap.connectionState == ConnectionState.waiting) {
//                print("Connection State :" + projectSnap.connectionState.toString());
            return Center(child: CircularProgressIndicator());
          }
          else
            return Center(child: Text("Error Loading Feed"));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: list(),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.125,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width*0.74,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Link to Post",
                      labelStyle: TextStyle(fontSize: 12,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20), gapPadding: 5),
                    ),
                    style: TextStyle(fontSize: 14),
                    keyboardType: TextInputType.url,
                    controller: _urlTextController,
                  ),
                ),
                (isPosting)?
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircularProgressIndicator(),
                ):
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed:() {
                        setState(() {
                          isPosting = true;
                          postFeed(_urlTextController.text);
                        });
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

}