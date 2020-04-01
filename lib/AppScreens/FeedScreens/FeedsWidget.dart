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
  bool isLoading = true;

  String getFeedTitle(link) {
    String _link=link.toString();
    if(_link.contains(Sources[0])) return sourcesFormatted[0];
    else if(_link.contains(Sources[1])) return sourcesFormatted[1];
    else if(_link.contains(Sources[2])) return sourcesFormatted[2];
    else
      return "";
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
        if (projectSnap.hasData) {
          List _rssList = projectSnap.data;
          _rssList.sort((a,b) => (b.pubDate.substring(5,25)).compareTo(a.pubDate.substring(5,25)));

          return ListView.builder(
              itemCount: _rssList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _rssList[index];

                UrlData _urlData = new UrlData(
                    url: item.link, title: item.title);
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10,10, 10, 0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(8),
                      child: ListTile(
                        isThreeLine: true,
                        title: title(item.title),
                        subtitle: subtitle(item.description, getFeedTitle(item.link)),
                        trailing: thumbnail((item.enclosure != null) ? item.enclosure.url : null),
                        contentPadding: EdgeInsets.all(5.0),
                        onTap: () =>
                            Navigator.pushNamed(
                                context, '/webView', arguments: _urlData),
                      ),
                    ),
                  );
              }
          );
        }
        else {
          return Center(child: CircularProgressIndicator());
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