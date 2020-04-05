import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:modular_login/AppScreens/FeedScreens/ListTileWidgetsModel.dart';
import 'package:modular_login/constants/globals.dart';
import '../../Models/RssFeedExtractionModel.dart';
import 'WebView.dart';

class FeedsWidget extends StatefulWidget {

  @override
  _FeedsWidgetState createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {

  RssFeedModel _rssFeedModel;
  bool isLoading = true;

  list() {
    return ListView.builder(
        itemCount: newsFeedList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = newsFeedList[index];

          UrlData _urlData = new UrlData(
              url: item.link, title: item.title);
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
                subtitle: feedSubtitle(item.source.value.toString()),
                trailing: thumbnail((item.enclosure != null) ? item.enclosure.url : null),
                onTap: () => Navigator.pushNamed(context, '/webView', arguments: _urlData),
              ),
            ),
          );
        }
    );
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
    return (isLoading) ?
    Center(child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        child: Image.asset("assets/washed_away_covid-19.gif"))) :
    list();
  }

}