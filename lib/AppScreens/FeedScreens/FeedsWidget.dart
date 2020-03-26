import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import '../../Models/ListTileWidgetsModel.dart';
import '../../Models/RssFeedExtractionModel.dart';
import 'WebView.dart';

class FeedsWidget extends StatefulWidget {

  @override
  _FeedsWidgetState createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {

  RssFeedModel _rssFeedModel;

  List feedItem = [];

  bool isLoading = true;

  GlobalKey<RefreshIndicatorState> _refreshKey;

  String getFeedTitle(link) {
    String _link=link.toString();
    if(_link.contains(Sources[0])) return sourcesFormatted[0];
    else if(_link.contains(Sources[1])) return sourcesFormatted[1];
    else if(_link.contains(Sources[2])) return sourcesFormatted[2];
    else
      return "";
  }

  getFeedList() async {
    feedItem = await _rssFeedModel.load();
  }

  //ListView Builder
  list() {

    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        if (projectSnap.hasData)
       { return ListView.builder(
           itemCount: projectSnap.data.length,
           itemBuilder: (BuildContext context, int index) {
             final item = projectSnap.data[index];

             UrlData _urlData = new UrlData(url: item.link, title: item.title);

             if (item.title.contains(filter1) || item.title.contains(filter2) || item.title.contains(filter3) ||
//              item.title.contains(filter4) || item.title.contains(filter5) ||
                 item.description.contains(filter1) || item.description.contains(filter2) || item.description.contains(filter3)
//              || item.description.contains(filter4) || item.title.contains(filter5)
             ) {
               return Padding(
                 padding: const EdgeInsets.fromLTRB(10.0,10,10,0),
                 child: Material(
                   elevation: 5.0,
                   borderRadius: BorderRadius.circular(15),
                   child: ListTile(
                     isThreeLine: true,
                     title: title(item.title),
                     subtitle: subtitle(item.description, getFeedTitle(item.link)),
                     leading: thumbnail(
                         (item.enclosure != null) ? item.enclosure.url : null),
                     contentPadding: EdgeInsets.all(5.0),
                     onTap: () => Navigator.pushNamed(context, '/webView', arguments: _urlData),
                     ),
                   ),
                 );
             } else
               return Container();
           }
           );}
        else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: _rssFeedModel.load(),
      );

  }

  body() {
    print("In FEED WIDGET CLASS");
    if (feedItem.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return RefreshIndicator(
        key: _refreshKey,
        child: list(),
        onRefresh: () => getFeedList(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    _rssFeedModel = new RssFeedModel();
//    feedItem =[];
  getFeedList();

  }

  @override
  Widget build(BuildContext context) {
    return list();
  }

}