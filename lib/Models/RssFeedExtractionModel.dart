import 'package:modular_login/Models/RssItemModel.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../constants/globals.dart';

class RssFeedModel {

  var urlList = urlForFeed;
  List<RssFeed> _rssFeedList;
  List _tempRssItemList;
  List _rssItemList ;

  load() async {
    if (newsFeedList.isEmpty) {
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
              CustomRssItem _customRssItem = CustomRssItem(
                title : _tempRssItemList[i][j].title,
                description: _tempRssItemList[i][j].description,
                link : _tempRssItemList[i][j].link,
                pubDate: _tempRssItemList[i][j].pubDate.toString(),
                showDate : _tempRssItemList[i][j].pubDate.toString(),
                source: _tempRssItemList[i][j].source.value,
                imageUrl: ""
              );
              _customRssItem.pubDate = convertDate(_customRssItem.pubDate);
              _rssItemList.add(_customRssItem);
            }
          }
        }
      } catch (e) {
        print(e);
      }

      _rssItemList.sort((a,b) => (DateTime.parse(b.pubDate).compareTo(DateTime.parse(a.pubDate))));
      newsFeedList.addAll(_rssItemList);
      print("LOAD Completed and RSS ITEM List Returned");
    }
  }

  convertDate(pubDate) {
    String newDate = "";
    newDate = newDate + pubDate.substring(12,16) + "-";
    switch(pubDate.substring(8,11)){
      case "Jan" :  {newDate = newDate + "01" + "-";break;}
      case "Feb" :  {newDate = newDate + "02" + "-";break;}
      case "Mar" :  {newDate = newDate + "03" + "-";break;}
      case "Apr" :  {newDate = newDate + "04" + "-";break;}
      case "May" :  {newDate = newDate + "05" + "-";break;}
      case "Jun" :  {newDate = newDate + "06" + "-";break;}
      case "Jul" :  {newDate = newDate + "07" + "-";break;}
      case "Aug" :  {newDate = newDate + "08" + "-";break;}
      case "Sep" :  {newDate = newDate + "09" + "-";break;}
      case "Oct" :  {newDate = newDate + "10" + "-";break;}
      case "Nov" :  {newDate = newDate + "11" + "-";break;}
      case "Dec" :  {newDate = newDate + "12" + "-";break;}
  }
  newDate = newDate + pubDate.substring(5,7) + " " +  pubDate.substring(17,25);
//    print("NewDat: $newDate");
    return newDate;
  }
}