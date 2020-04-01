import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';


class RssFeedModel {

  var urlList = urlForFeed;
  List<RssFeed> _rssFeedList;
  List _tempRssItemList;
  List _rssItemList ;

  load() async {
    _rssFeedList = [];
    _tempRssItemList = [];
    _rssItemList = [];
    print("Inside RSS Model");
    try {
      for(int i = 0;i<urlList.length ; i++) {
        http.Client client = http.Client();
        http.Response response = await client.get(urlList[i]);
        _rssFeedList.add(RssFeed.parse(response.body));
        _tempRssItemList.add(RssFeed.parse(response.body).items);
        for (int j = 0; j < _tempRssItemList[i].length; j++) {
          if (filterData(_tempRssItemList[i][j].title) || filterData(_tempRssItemList[i][j].description)) {
//            _tempRssItemList[i][j].pubDate = _tempRssItemList[i][j].pubDate.substring(5,16);
//            print(_tempRssItemList[i][j].pubDate.toString());
            _rssItemList.add(_tempRssItemList[i][j]);
//          print(_tempRssItemList[i][j].runtimeType);
          }
        }
      }
    } catch (e) {
      print(e);
    }

//    _rssItemList.sort((a,b) => (b.pubDate.substring(5,25)).compareTo(a.pubDate.substring(5,25)));

    print("LOAD Completed and RSS ITEM List Returned");
    return _rssItemList;
  }
}