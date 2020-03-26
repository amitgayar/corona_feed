import 'package:modular_login/constants/constants.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;

class RssFeedModel {

  var urlList = urlForFeed;
  List<RssFeed> _rssFeedList ;
  List _rssItemList ;
  List _tempRssItemList;

  load() async {
    print("Inside RSS Model");
    _rssFeedList = [];
    _rssItemList = [];
    _tempRssItemList=[];

    for(int i = 0;i<urlList.length;i++){
      try {
        http.Client client = http.Client();
        http.Response response = await client.get(urlList[i]);
        _rssFeedList.add(RssFeed.parse(response.body));
        _tempRssItemList.add(RssFeed.parse(response.body).items);

        for(int j = 0; j < _tempRssItemList[i].length ; j++){
          _rssItemList.add(_tempRssItemList[i][j]);
        }
      } catch (e,stackTrace) {
        print(e);
        print(stackTrace);
      }
    }
    _rssItemList.shuffle();
    print("LOAD Completed and RSS ITEM List Returned");
    return _rssItemList;
  }
}