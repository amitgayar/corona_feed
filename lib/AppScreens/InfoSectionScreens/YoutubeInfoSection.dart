import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeInfoSection extends StatefulWidget {
  @override
  _YoutubeInfoSectionState createState() => _YoutubeInfoSectionState();
}

class _YoutubeInfoSectionState extends State<YoutubeInfoSection> {

  YoutubePlayerController _controller;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  List videoId = [
    'lgkZC_Ss6YE'
//    YoutubePlayer.convertUrlToId(youtubeUrl1),
//    YoutubePlayer.convertUrlToId(youtubeUrl2),
//    YoutubePlayer.convertUrlToId(youtubeUrl3),
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoId.first,
      flags: YoutubePlayerFlags(
        mute: false,
        controlsVisibleAtStart :true,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHideAnnotation: true,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
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
      onReady: () {_isPlayerReady = true;},
      onEnded: (data) {_controller.load(videoId[(videoId.indexOf(data.videoId) + 1) % videoId.length]);},
    );
  }
}