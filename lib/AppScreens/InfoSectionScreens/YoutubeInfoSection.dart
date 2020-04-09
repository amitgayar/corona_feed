import 'package:flutter/material.dart';
import 'package:modular_login/Models/youtubeVideoModel.dart';
import 'package:modular_login/Services/youtubeApiService.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:toast/toast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeInfoSection extends StatefulWidget {

  YoutubeInfoSection({ @required Key key}) :super(key:key);

  @override
  _YoutubeInfoSectionState createState() => _YoutubeInfoSectionState();
}

class _YoutubeInfoSectionState extends State<YoutubeInfoSection> {
//
//  YoutubePlayerController _controller;
//  PlayerState _playerState;
//  YoutubeMetaData _videoMetaData;
//  double _volume = 100;
//  bool _muted = false;
//  bool _isPlayerReady = false;
//
//  List videoId = [
//    'lgkZC_Ss6YE'
////    YoutubePlayer.convertUrlToId(youtubeUrl1),
////    YoutubePlayer.convertUrlToId(youtubeUrl2),
////    YoutubePlayer.convertUrlToId(youtubeUrl3),
//  ];
//
//  @override
//  void initState() {
//    super.initState();
//    _controller = YoutubePlayerController(
//      initialVideoId: videoId.first,
//      flags: YoutubePlayerFlags(
//        mute: false,
//        controlsVisibleAtStart :true,
//        autoPlay: false,
//        disableDragSeek: false,
//        loop: false,
//        isLive: false,
//        forceHideAnnotation: true,
//        forceHD: false,
//        enableCaption: true,
//      ),
//    )..addListener(listener);
//    _videoMetaData = YoutubeMetaData();
//    _playerState = PlayerState.unknown;
//  }
//
//  void listener() {
//    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//      setState(() {
//        _playerState = _controller.value.playerState;
//        _videoMetaData = _controller.metadata;
//      });
//    }
//  }
//
//  @override
//  void deactivate() {
//    // Pauses video while navigating to next page.
//    _controller.pause();
//    super.deactivate();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }

  YoutubePlayerController _controller;
  List<Video> videoList =[] ;
  List<Video> videoList1 =[] ;
  List<Video> videoList2 =[] ;
  List<Video> videoList3 =[] ;
  static String initVideoId = YoutubePlayer.convertUrlToId(initialVideoId);
  String dropdownValue ;
  String currentId = initVideoId;
  int currentPlayList = 1;
  int currIndex = 0;

  @override
  void initState() {
    super.initState();
    _initPlayerVideos();
    _initController(currentId);
  }

  _initPlayerVideos() async {
    print("Entered in _initPlayerVideos");
    videoList1 = await APIService.instance.fetchVideosFromPlaylist(playlistId: "PLGqF2Eq4iV7_vrLoZJiqJdptLlAlEBRRQ");
    videoList2 = await APIService.instance.fetchVideosFromPlaylist(playlistId: "PLGqF2Eq4iV78hhD6m_hDUV1b0C8_9X-sk");
//    videoList3 = await APIService.instance.fetchVideosFromPlaylist(playlistId: "PLGqF2Eq4iV789JKyN_780aoZnDc954JvL");
    if (currentPlayList == 1) {
      videoList.addAll(videoList1);
    }else if (currentPlayList == 2) {
      videoList.addAll(videoList2);
    }else
      videoList.addAll(videoList3);
    setState(() {});
  }

  _initController(initial) {
    _controller = YoutubePlayerController(
        initialVideoId: initial,
        flags: YoutubePlayerFlags(
          controlsVisibleAtStart: true,
          autoPlay: false,
        )
    );
  }

  buildVideoPlayer() {
    currentId = videoList[currIndex].id;
    print("Current Index in buildVideo $currentId");
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,10),
      child: YoutubePlayer(
        controller: _controller,
        onReady: () => _controller.pause() ,
        onEnded: (data) {
          Toast.show("Loading Next Video", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          currIndex = currIndex+1;
          currentId = videoList[currIndex].id;
          _controller.load(videoList[currIndex].id);
        },
        showVideoProgressIndicator : true
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.fromLTRB(20,10,20,0),
//                child: Text("Select Playlist to Play",textAlign: TextAlign.left,
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      color: Colors.indigo[900]
//                  ),
//                ),
//              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    hint: Text("Select Playlist to Play"),
                    value: dropdownValue,
                    isExpanded: true,
                    icon: Icon(Icons.menu),
                    style: TextStyle(
                        color: Colors.indigo[900]
                    ),
                    items: <String> ["Know About Coronavirus","PM Narendra Modi on Coronavirus","Follow #COVID-19"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                    onChanged: (String newValue) {
                      if (_controller.value.isReady) {
                        print("Selected Dropdown : $newValue");
//                        _controller.pause();
                        String temp = dropdownValue;
                        dropdownValue = newValue;
//                        print("VideoList before Clear : ${videoList.length}");
                        if(newValue != temp){
                          videoList.clear();
//                          print("VideoList after Clear : ${videoList.length}");
                          if(newValue == "Know About Coronavirus") {
                            videoList.addAll(videoList1);
                            currentPlayList = 1;
//                            print("VideoList after Update : ${videoList.length}");
                          }else if(newValue == "PM Narendra Modi on Coronavirus") {
                            currentPlayList = 2;
                            videoList.addAll(videoList2);
//                            print("VideoList after Update : ${videoList.length}");
                          }else if(newValue == "Follow #COVID-19") {
                            currentPlayList = 3;
                            videoList.addAll(videoList3);
//                            print("VideoList after Update : ${videoList.length}");
                          }
                          initVideoId = videoList[0].id;
                          Toast.show("Loading playlist", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          setState(() {
                            _controller.load(initVideoId);
                            _controller.play();
                          });
                        }
                        else {
                          Toast.show("Already Playing this Playlist", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        }
                      }else {
                        Toast.show("Please Wait, Player is Loading", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: ((videoList1.isNotEmpty || videoList2.isNotEmpty || videoList3.isNotEmpty)) ?
          Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: buildVideoPlayer()
          ):
          Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.width * 0.60,
              padding: EdgeInsets.all(10),
              child: Center(
                child: CircularProgressIndicator(),
              )
          ),
        ),
      ],
    );
  }
}