import 'package:flutter/material.dart';
import 'package:modular_login/Models/UrlDataModel.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:modular_login/AppScreens/FeedScreens/ListTileWidgetsModel.dart';
import 'package:modular_login/constants/globals.dart';
import '../../Models/RssFeedExtractionModel.dart';

class NewsTabWidget extends StatefulWidget {

  @override
  _NewsTabWidgetState createState() => _NewsTabWidgetState();
}

class _NewsTabWidgetState extends State<NewsTabWidget> {

  RssFeedModel _rssFeedModel;
  bool isLoading = true;

  list() {
    return ListView.builder(
        itemCount: newsFeedList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = newsFeedList[index];

          UrlData _urlData = new UrlData(url: item.link, title: item.title);
          return Padding(
            padding: const EdgeInsets.fromLTRB(10,10, 10, 0),
            child: Material(
              color: Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(7),
              shadowColor: baseColor,
              child: ListTile(
                isThreeLine: true,
                title: title(item.title),
                subtitle: threeItemSubtitle(item.description,item.source,item.showDate),
//                trailing: thumbnail((item.imageUrl != null) ? item.imageUrl : null),
                onTap: () => Navigator.pushNamed(context, '/webView', arguments: _urlData),
              ),
            ),
          );
        }
    );
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _rssFeedModel = new RssFeedModel();
    if (isLoading) {
      _rssFeedModel.load().then((val){
        isLoading = false;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Get your news link fact checked",
        onPressed: () {
          UrlData _urlData = new UrlData(url: chatUrl , title: "Chat : Send news links to get fact checked");
          Navigator.pushNamed(context, '/webView', arguments: _urlData);
        },
        child: Icon(Icons.question_answer,color: Colors.white),
        backgroundColor: baseColor,
      ),
      body: (isLoading) ?
      Center(child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Image.asset("assets/washed_away_covid-19.gif")))
          :
      list(),
    );
  }

}