import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedsWidget extends StatefulWidget {

  FeedsWidget() : super();

  @override
  _FeedsWidgetState createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {

  String url = "https://www.sciencedaily.com/rss/health_medicine/viruses.xml";
  RssFeed _feed;
  String filter1 = "Coronavirus", filter2 = "COVID-19", filter3 = "SARS-CoV-2";

  static const String placeholderImg = 'images/no_image.png';
  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
      return;
    }
  }

  load() async {
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        return;
      }
      updateFeed(result);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(url);
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }


  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    load();
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500),
      maxLines: 1,
      overflow: TextOverflow.clip,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.normal),
      maxLines: 1,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child:
        (imageUrl != null) ? CachedNetworkImage(
          placeholder: (context, url) => Image.asset(placeholderImg),
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

  bool filter(String keyword){
    return true;
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        if(filter(filter1) || filter(filter2) || filter(filter3)){

        }
        else{
          index++;
          return Container();
        }
        return Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: title(item.title),
                subtitle: subtitle(item.description),
                leading: thumbnail((item.enclosure!=null)?item.enclosure.url:null),
                contentPadding: EdgeInsets.all(5.0),
                onTap: () => openFeed(item.link),
              ),
              Container(
                height: 2,
                color: Colors.blue,
              )
            ],
          ),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty() ?
       Center( child: CircularProgressIndicator(),) :
       RefreshIndicator(
         key: _refreshKey,
         child: list(),
         onRefresh: () => load(),
       );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}