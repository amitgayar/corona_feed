import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:modular_login/constants/constants.dart';

import 'Api.dart';

class CRUDModel extends ChangeNotifier {

  Api _api = new Api();

  ///Gets the Email ID of Current Logged in user
  getCurrentUserEmail() async {
    return await FirebaseAuth.instance.currentUser()
        .then((_currentUser) {
          return _currentUser.email;
    }).catchError((onError){
      print("IN CRUD MODEL ERROR Email Fetch : " + onError.toString());
    });
  }

  ///Posts the feedItem in fireStore data
  createUserFeedDocument(email,userFeedItemMap){
    _api.createDocument(email,userFeedItemMap);
  }

  ///Gets the MetaData from the URL
  getMetaDataFromUrl(url) async {
    try {
      if(checkURL(url)){
        http.Client client = http.Client();
        http.Response response = await client.get(url);
        if(response.statusCode == 200)
          return response.body;
        else
          return null;
      }
      else
        return null;
    } catch (e) {
      print("Caught in MetadataFromUrl : "+e.toString());
      return null;
    }
  }

  ///Gets the User Feed for specific email
  fetchUserFeed() async {
    var list = await _api.getCompleteUserData(await getCurrentUserEmail()); //TODO getValue
    print("In Crud Model Fetch User Feed");
    return list ;
  }

  ///Gets the complete Community Feed
  Future<List> fetchCommunityFeed() async {
    print("In Crud Model Fetch Community Feed");
    List list = await _api.getCommunityFeedData();
    print('In Crud Model Fetch Community Feed list');
    print(list);
    return list ;
  }

//  Stream<QuerySnapshot> fetchFeedAsStream() {
//    print("In Crud Model Fetch Feed as a stream");
//    return _api.streamDataCollection();
//  }
//
//  Future<FeedItem> getFeedById(String id) async {
//    var doc = await _api.getDocumentById(id);
//    return  FeedItem.fromMap(doc.data) ;
//  }
//
//  Future addFeed(FeedItem data) async{
//    var result  = await _api.addDocument(data.toJson()) ;
//    return ;
//  }
//
//  Future removeFeed(String id) async{
//    await _api.removeDocument(id) ;
//    return ;
//  }
//  Future updateFeed(FeedItem data) async{
//    await _api.updateDocument(data.toJson()) ;
//    return ;
//  }

//  Future<List<FeedItem>> fetchFeed() async {
//    print("Inside fetchFeed ${_api.ref}");
//    var result = await _api.getDataCollection();
//    _feedItem = result.documents
//        .map((doc) => FeedItem.fromMap(doc.data))
//        .toList();
//    return _feedItem;
//  }

}