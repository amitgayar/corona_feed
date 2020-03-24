import 'package:modular_login/constants/constants.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;

class RssFeedModel {

  var urlList = urlForFeed;
  int itemCount ;
  List<RssFeed> _rssFeedList ;
  List _rssItemList ;
  List _tempRssItemList;

  load() async {
    print("Inside RSS Model");
    itemCount = 0;
    _rssFeedList = [];
    _rssItemList = [];
    _tempRssItemList=[];

    for(int i = 0;i<urlList.length;i++){
//      print("Loop Run "+ i.toString());
      try {
        http.Client client = http.Client();
        http.Response response = await client.get(urlList[i]);
        _rssFeedList.add(RssFeed.parse(response.body));
//        print(RssFeed.parse(response.body).items.length);
        itemCount = itemCount + RssFeed.parse(response.body).items.length;
        _tempRssItemList.add(RssFeed.parse(response.body).items);
      } catch (e,stackTrace) {
        print(e);
        print(stackTrace);
      }
    }
    for(int i = 0 ; i <_rssFeedList.length ; i++){
      for(int j = 0; j < _tempRssItemList[i].length ; j++){
        _rssItemList.add(_tempRssItemList[i][j]);
      }
    }

    _rssItemList.shuffle();
//    print("FEED LIST: " + _RssFeedList.toString());
//    print("FEED ITEM LIST: " + _RssItemList.toString());
//    print("FEED ITEM Count: ");
//    print(itemcount);
//    print("FEED ITEM LIST: " + _RssItemList.length.toString())
  print("LOAD Completed");
  }

  getItemCount() {return itemCount; }
  getFeedItemList() { return _rssItemList; }
  getFeedList() { return _rssFeedList; }
}