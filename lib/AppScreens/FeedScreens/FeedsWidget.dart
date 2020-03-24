import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Models/RssFeedModel.dart';
import 'WebView.dart';

class FeedsWidget extends StatefulWidget {

  @override
  _FeedsWidgetState createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {

  RssFeedModel _rssFeedModel;

  List rssFeed;
  List feedItem;

  GlobalKey<RefreshIndicatorState> _refreshKey;

  //title widget for listTile
  title(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 7,right: 8,bottom : 5.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500),
        maxLines:1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  //subtitle widget for listTile
  subtitle(subTitle,source) {
    String sub = subTitle;
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            (sub.isNotEmpty) ? subTitle : "Tap to Read" ,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal),
            maxLines: 2,
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            source ,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300),
            maxLines: 1,
          )
        ],
      ),
    );
  }

  //thumbnail widget for listTile
  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: CircleAvatar(
        radius: 35,
        child:
        (imageUrl != null) ? CachedNetworkImage(
          placeholder: (context, url) => Image.asset("/assets/no_image_availaible_.jpg"),
          imageUrl: imageUrl,
          height: 50,
          width: 70,
          alignment: Alignment.center,
          fit: BoxFit.fill,
        ) :
        Image.asset("assets/defaultThumbnail.png"),
      ),
    );
  }

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
    return ListView.builder(
      itemCount: _rssFeedModel.getItemCount(),
//        itemCount: 500,
      itemBuilder: (BuildContext context, int index) {
        final item = _rssFeedModel.getFeedItemList()[index];
//        final feed = _rssFeedModel.getFeedList()[index];

        UrlData _urlData = new UrlData(url: item.link, title: item.title);

        if (item.title.contains(filter1) || item.title.contains(filter2) || item.title.contains(filter3) ||
            item.description.contains(filter1) || item.description.contains(filter2) || item.description.contains(filter3)) {
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
        onRefresh: () => _rssFeedModel.load(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    _rssFeedModel = new RssFeedModel();
    _rssFeedModel.load();
    rssFeed = _rssFeedModel.getFeedList();
    feedItem = _rssFeedModel.getFeedItemList();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

}