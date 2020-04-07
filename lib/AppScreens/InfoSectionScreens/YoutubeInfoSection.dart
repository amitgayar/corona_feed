import 'package:flutter/material.dart';
import 'package:modular_login/Models/youtubeVideoModel.dart';
import 'package:modular_login/Services/youtubeApiService.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeInfoSection extends StatefulWidget {
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
  String initVideoId = YoutubePlayer.convertUrlToId(initialVideoId);
  String dropdownValue = 'Covid Info';
  String currentId;
  int currIndex = 0;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  _initPlayer() async {
    print("Entered in INITchannel");
    videoList = await APIService
        .instance.fetchVideosFromPlaylist(playlistId: playlist[dropdownValue]);
    setState(() {
      currentId = videoList[0].id;
    });
  }

  buildVideoPlayer(videoId) {
    return GestureDetector(
      onTap: () => _controller.pause(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: YoutubePlayer(
          controller: _controller,
          progressIndicatorColor: baseColor,
          topActions: <Widget>[
            SizedBox(width: 8.0),
            Text(
              _controller.metadata.title,
              style: TextStyle(
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
//        onReady: () {_controller.play();},
        onEnded: (data) {
          currIndex = currIndex+1;
          _controller.load(videoList[currIndex].id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    _controller = YoutubePlayerController(
      initialVideoId: initVideoId,
      flags: YoutubePlayerFlags(
        mute: false,
        controlsVisibleAtStart: true,
        autoPlay: false,
      ),
    );

    return Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.70,
            padding: EdgeInsets.fromLTRB(20,5,20,5),
            child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.menu),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    color: Colors.indigo[900]
                ),
                underline: Container(
                  height: 2,
                    color: Colors.indigo[900]
                ),
                items: <String> ["Covid Info","PM Modi on Convid","#Covid 19"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              onChanged: (String newValue) {
                dropdownValue = newValue;
                setState(() {});
                _initPlayer();
              },
            ),
          ),
          Container(
            height: 200,
            child: (videoList.isNotEmpty) ?
                buildVideoPlayer(currentId) :
            Center(
              child: LinearProgressIndicator(),
            ),
          ),
        ],
      );
  }
}