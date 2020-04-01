import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modular_login/Models/FeedItemModel.dart';
import 'package:modular_login/constants/globals.dart';

class Api{

  CollectionReference ref = Firestore.instance.collection('FeedData');

  bool isLoggedIn(){
    if (FirebaseAuth.instance.currentUser() != null)
      return true;
    else
      return false;
  }

  /// Creates and updates data while posting feed
  void createDocument(email,Map feedItemMap) async {
    String datePosted = DateTime.now().toString().substring(0,11);
    List feedItemMapListElement = [feedItemMap];

    if (isLoggedIn()) {
      ref.document(email)
          .get().then((thisDoc) {

        if (thisDoc.exists) {
          ref.document(email)
              .updateData({
            datePosted : FieldValue.arrayUnion(feedItemMapListElement)
          });
        } else {
          ref.document(email)
              .setData({
            datePosted : FieldValue.arrayUnion(feedItemMapListElement)
          });
        }
      });
    }else{
      print("No User Logged");
    }
  }

  ///Fetch Data from the document [thisDoc]
  List getDataFromDocument(thisDoc) {
    print("Entered in getDataFromDocuments");
    List feedList ;

    if(thisDoc.exists){
      // Returns list of documents
//      print("thisDoc.data : ${thisDoc.data}");
      Map<String, dynamic> tempFeedMap = Map.from(thisDoc.data);
//      print("tempFeedMap : ${thisDoc.data}");

      List tempListFromDocumentMap =  tempFeedMap.values.toList();
//      print("tempListFromDocumentMap : $tempListFromDocumentMap");

      List finalList= [];
      for(int i=0; i<tempListFromDocumentMap.length; i++){
        for(int j=0; j<tempListFromDocumentMap[i].length; j++){
//          FeedItem _feedItem = FeedItem.fromMap(tempListFromDocumentMap[i][j]);
//          print("Data [$i][$j] : ${_feedItem.runtimeType}");
//          finalList.add(_feedItem);
          finalList.add(tempListFromDocumentMap[i][j]);
//          print("Data [$i][$j] : ${tempListFromDocumentMap[i][j]}");

        }
      }
//      print("Final List : $finalList");
      return finalList;
    }else{
      // No post by User
      print("thisDoc.exists ${thisDoc.exists}");
      feedList = null;
      return feedList;
    }
  }

  ///Gets Data for a user with id as [email]
  getMyFeedData(email) async {
    print("Fetching data for $email");
    return ref.document(email)
        .get().then((thisDoc){
          List temp = getDataFromDocument(thisDoc);
          myFeedCount = temp.length;
          return temp ;
        });
  }

  ///Gets Data for all the users
  getCommunityFeedData() async {
    print("In API Fetching Community Feed data...");
    List feedList = [];

    await ref.getDocuments()
        .then((QuerySnapshot querySnapshot) {
          print("Total no of Users with Post : ${querySnapshot.documents.length}");
          for(int i = 0 ; i < querySnapshot.documents.length ; i++){
//            print("Data for User ${querySnapshot.documents[i].documentID}  =  ${querySnapshot.documents[i].data}");
            feedList.addAll(getDataFromDocument(querySnapshot.documents[i]));
          }
          communityFeedCount = feedList.length;
//          print("FeedList in Api  : $feedList");
    });
    return feedList;
  }


  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
  }

  Stream<QuerySnapshot> streamDataCollection() {
    print("IN API Inside streamDataCollection");
    print(ref.snapshots);
    return ref.snapshots() ;
  }

  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data) {
    return ref.document(data['datePosted']).updateData(data) ;
  }

}