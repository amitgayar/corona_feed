import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  getDataFromDocument(thisDoc){
    print("Entered inside getDataFromDocuments");
    List tempFeedList ;
    List feedList ;
    if(thisDoc.exists){
      // Returns list of documents
//      print("thisDoc.data : ${thisDoc.data}");

//      thisDoc.data.forEach((k,v) => tempFeedList.add(v));

//      print("tempFeedList.length = ${tempFeedList.length}");
      if (tempFeedList != null) {
        for(int i =0 ; i<tempFeedList.length ; i++){
        //        print("i = $i");
        //        print("tempFeedList[$i].length = ${tempFeedList[i].length}");
          for(int j =0 ; j<tempFeedList[i].length ; j++){
        //          print("j = $j");
        //          print("tempFeedList[$i][$j].length = ${tempFeedList[i][j]}");
        //          feedList.add(FeedItem.fromMap(tempFeedList[i][j]));
          }
        }
      }
//      print("List " + feedList.toString());
    }else{
      // No post by User
      print("thisDoc.exists ${thisDoc.exists}");
      feedList = null;
    }
    return feedList;
  }

  ///Gets Data for a user with id as [email]
  getCompleteUserData(email) async {
    print("Fetching data for $email");
    List feedList = [];
    ref.document(email)
        .get().then((thisDoc){
          feedList = getDataFromDocument(thisDoc);
        });
//    feedList.forEach((f) {print(f.data);});
    return feedList;
  }

  ///Gets Data for all the users
  getCommunityFeedData() async {
    print("Fetching Community Feed data...");
    List feedList = [];
    ref.getDocuments()
        .then((QuerySnapshot querySnapshot) {
          print("${querySnapshot.documents.length}");
          for(int i = 0 ; i < querySnapshot.documents.length ; i++){
//            print("Data for ${querySnapshot.documents[i].documentID}  =  ${querySnapshot.documents[i].data}");
          feedList.add(getDataFromDocument(querySnapshot.documents[i]));
          }
          print("Community Feed List : $feedList");
          print("Query Snapshot Data ${querySnapshot.documents.toString()}");
    });
    return feedList;
  }


  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
  }

  Stream<QuerySnapshot> streamDataCollection() {
    print("IN API Inside streamDataCollection");
    return ref.snapshots() ;
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
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