import 'package:flutter/material.dart';

import 'WebView.dart';
import '../../Models/CRUDModel.dart';
import '../../Models/ListTileWidgetsModel.dart';

class MyFeed extends StatefulWidget {
  @override
  _MyFeedState createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {

  CRUDModel crudModel = new CRUDModel();

  //TODO Not Showing data
  list() {
    return FutureBuilder(
        future: crudModel.fetchUserFeed(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
//                print('projectSnap data is: ${projectSnap.data} ');
            return Center(child: Text("Please Share Something...."));
          }

          if(projectSnap.hasData){
//                print('projectSnap data is: ${projectSnap.data} ');
            var feedItemMapList = projectSnap.data;

            return ListView.builder(
                itemCount: feedItemMapList.length,
                itemBuilder: (BuildContext context, int index) {

                  final item = feedItemMapList[index];
                  print("Item $index is $item");
                  UrlData _urlData = new UrlData(url: item.url, title: item.title);

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,10,10,0),
                    child: Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          isThreeLine: true,
                          title: title(item.title),
                          subtitle: subtitle(item.description,item.datePosted),
                          trailing: thumbnail(null),
                          contentPadding: EdgeInsets.all(5.0),
                          onTap: () => Navigator.pushNamed(context, '/webView', arguments: _urlData),
                        ),
                      ),
                    ),
                  );
                }
            );
          } else if(projectSnap.connectionState == ConnectionState.waiting) {
//                print("Connection State :" + projectSnap.connectionState.toString());
            return Center(child: CircularProgressIndicator());
          }else
            return Center(child: Text("Error Loading Feed"));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Feeds'),
      ),
      body: list(),
    );
  }
}