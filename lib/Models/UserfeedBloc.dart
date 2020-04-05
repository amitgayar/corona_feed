import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modular_login/Models/CRUDModel.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class feedListBloc {

  bool showIndicator = false;
  List<DocumentSnapshot> documentList;
  CRUDModel crudModel = new CRUDModel();

  BehaviorSubject<List<DocumentSnapshot>> listController;

  BehaviorSubject<bool> showIndicatorController;

  feedListBloc() {
    listController = BehaviorSubject<List<DocumentSnapshot>>();
    showIndicatorController = BehaviorSubject<bool>();
  }

  Stream get getShowIndicatorStream => showIndicatorController.stream;

  Stream<List<DocumentSnapshot>> get feedStream => listController.stream;

/*This method will automatically fetch first 10 elements from the document list */
  Future fetchFirstList() async {
    try {
      documentList = await crudModel.fetchCommunityFeed(null);
      listController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          listController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      listController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      listController.sink.addError(e);
    }
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextMovies() async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
      await crudModel.fetchCommunityFeed(documentList[documentList.length - 1]);
      documentList.addAll(newDocumentList);
      listController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          listController.sink.addError("No Data Available");
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
      }
    } on SocketException {
      listController.sink.addError(SocketException("No Internet Connection"));
      updateIndicator(false);
    } catch (e) {
      updateIndicator(false);
      print(e.toString());
      listController.sink.addError(e);
    }
  }

/*For updating the indicator below every list and paginate*/
  updateIndicator(bool value) async {
    showIndicator = value;
    showIndicatorController.sink.add(value);
  }

  void dispose() {
    listController.close();
    showIndicatorController.close();
  }
}