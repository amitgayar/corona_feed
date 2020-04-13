import 'package:modular_login/Models/youtubeVideoModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'constants.dart';

int communityFeedCount = 0;
int myFeedCount = 0;
List newsFeedList = [];

List<Video> videoList =[] ;
List<Video> videoList1 =[] ;
List<Video> videoList2 =[] ;
List<Video> videoList3 =[] ;
String initVideoId = YoutubePlayer.convertUrlToId(initialVideoId);
String dropdownValue = "Know About Coronavirus";
String currentId = initVideoId;
int currentPlayList = 1;
int currIndex = 0;