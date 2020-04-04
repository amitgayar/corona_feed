import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modular_login/constants/globals.dart';

class Api{

  CollectionReference ref = Firestore.instance.collection('CommunityFeed');
  CollectionReference userRef = Firestore.instance.collection('FeedData');


  bool isLoggedIn(){
    if (FirebaseAuth.instance.currentUser() != null)
      return true;
    else
      return false;
  }

  /// Creates and updates data while posting feed
  createDocument(title,Map<String,dynamic> feedItemMap) async{
    if (isLoggedIn()) {
      await ref.document(title)
          .get().then((thisDoc) {
        if (!thisDoc.exists) {
          ref.document(title)
              .setData(feedItemMap);
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

  bool hasMore = true;
  int docLimit = 10;
  DocumentSnapshot lastDocument;

  ///Gets Data for a user with id as [email]
  Future<List<DocumentSnapshot>> getMyFeedData(email) async {
    print("Fetching data for $email");
    Query q = ref.where("postedBy",isEqualTo: email).orderBy("datePosted",descending: true);
    QuerySnapshot querySnapshot = await q.getDocuments();
    return querySnapshot.documents;
  }

  ///Gets Data for a user with id as [email]
  Future<List<DocumentSnapshot>> getCommunityFeedData(DocumentSnapshot lastDoc) async {
    print("Fetching Community data ");
    print("ref : $ref");
    Query q;
    if(lastDoc == null){
      print("lastDoc : ${lastDoc} in null true case $docLimit");
      q = ref.orderBy("datePosted",descending: true).limit(docLimit);
    }else {
      print("lastDoc : ${lastDoc.data.toString()} in null false case $docLimit");
      q = ref.orderBy("datePosted",descending: true).startAfterDocument(lastDoc).limit(docLimit);
    }
    QuerySnapshot querySnapshot = await q.getDocuments();
    return querySnapshot.documents;
  }

  Future<QuerySnapshot> getDataCollection() {
    return userRef.getDocuments() ;
  }

  Stream<QuerySnapshot> streamDataCollection() {
    print("IN API Inside streamDataCollection");
    print(userRef.snapshots);
    return userRef.snapshots() ;
  }

  Future<void> removeDocument(String id){
    return userRef.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return userRef.add(data);
  }

  Future<void> updateDocument(Map data) {
    return userRef.document(data['datePosted']).updateData(data) ;
  }

}