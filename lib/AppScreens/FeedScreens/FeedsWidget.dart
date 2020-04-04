import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:modular_login/AppScreens/FeedScreens/ListTileWidgetsModel.dart';
import '../../Models/RssFeedExtractionModel.dart';
import 'WebView.dart';

class FeedsWidget extends StatefulWidget {

  @override
  _FeedsWidgetState createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {

  RssFeedModel _rssFeedModel;
  bool isLoading = true;

  //ListView Builder
  list() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        if (projectSnap.hasData) {
          List _rssList = projectSnap.data;
//          _rssList.sort((a,b) => (b.pubDate.substring(5,25)).compareTo(a.pubDate.substring(5,25)));

          return ListView.builder(
              itemCount: _rssList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _rssList[index];

                UrlData _urlData = new UrlData(
                    url: item.link, title: item.title);
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10,10, 10, 0),
                    child: Material(
                      color: Colors.white,
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(7),
                      shadowColor: baseColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top:20,bottom: 10),
                        child: ListTile(
                          isThreeLine: true,
                          title: title(item.title),
                          subtitle: feedSubtitle(item.source.value.toString()),
                          trailing: thumbnail((item.enclosure != null) ? item.enclosure.url : null),
                          onTap: () => Navigator.pushNamed(context, '/webView', arguments: _urlData),
                        ),
                      ),
                    ),
                  );
              }
          );
        }
        else {
          return Center(child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Image.asset("assets/washed_away_covid-19.gif")));
        }
      },
      future: _rssFeedModel.load(),
    );
  }

  @override
  void initState() {
    super.initState();
    _rssFeedModel = new RssFeedModel();
  }

  @override
  Widget build(BuildContext context) {
    return list();
  }

}