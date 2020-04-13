import 'package:flutter/material.dart';
import 'package:modular_login/Models/youtubeVideoModel.dart';
import 'package:modular_login/Services/youtubeApiService.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:modular_login/constants/globals.dart';
import 'package:toast/toast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeInfoSection extends StatefulWidget {

  @override
  _YoutubeInfoSectionState createState() => _YoutubeInfoSectionState();
}

class _YoutubeInfoSectionState extends State<YoutubeInfoSection> {

  YoutubePlayerController _controller;
//  List<Video> videoList =[] ;
//  List<Video> videoList1 =[] ;
//  List<Video> videoList2 =[] ;
//  List<Video> videoList3 =[] ;
//  static String initVideoId = YoutubePlayer.convertUrlToId(initialVideoId);
//  String dropdownValue = "Know About Coronavirus";
//  String currentId = initVideoId;
//  int currentPlayList = 1;
//  int currIndex = 0;

  @override
  void initState() {
    super.initState();
    _initPlayerVideos().whenComplete(()=>  _loadVideoList());
    _initController(currentId);
    setState(() {});
  }

  _initPlayerVideos() async {
    print("Entered in _initPlayerVideos");
    if (videoList1.length == 0) {
      videoList1 = await APIService.instance.fetchVideosFromPlaylist(playlistId: "PLGqF2Eq4iV7_vrLoZJiqJdptLlAlEBRRQ");
      print("Inside _initPlayerVideos after loading videoList1 ${videoList1.length}");
    }
    if (videoList2.length == 0) {
      videoList2 = await APIService.instance.fetchVideosFromPlaylist(playlistId: "PLGqF2Eq4iV78hhD6m_hDUV1b0C8_9X-sk");
      print("Inside _initPlayerVideos after loading videoList2 ${videoList2.length}");
    }
    if (videoList3.length == 0) {
      videoList3 = await APIService.instance.fetchVideosFromPlaylist(playlistId: "PL1a9DHjZmejE-Ep2PAu2OR8HBfLP0BLIk");
      print("Inside _initPlayerVideos after loading videoList3 ${videoList3.length}");
    }
    setState(() {});
  }

  _loadVideoList() async{
    if (videoList.length == 0) {
      if (currentPlayList == 1) {
        print("Length of videolist1 ${videoList1.length}");
        videoList.addAll(videoList1);
        print("Video Length on adding videolist1 ${videoList.length}");
      }else if (currentPlayList == 2) {
        print("Length ofvideolist2 ${videoList2.length}");
        videoList.addAll(videoList2);
        print("Video Length on adding videolist2 ${videoList.length}");
      }else if (currentPlayList == 3){
        print("Length ofvideolist3 ${videoList3.length}");
        videoList.addAll(videoList3);
        print("Video Length on adding videolist3 ${videoList.length}");
      }
    }
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
    print("Inside BuildVideoPlayer");
    print("VideoList Length ${videoList.length}");
    currentId = initVideoId;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,10),
      child: YoutubePlayer(
        controller: _controller,
        onReady: () => _controller.pause(),
        onEnded: (val) {
          print("Inside build onEnded val $val");
          currIndex = currIndex+1;
          currentId = videoList[currIndex].id;
          print("Inside build onEnded ${videoList.length}");
          _controller.load(videoList[currIndex].id);
          Toast.show("Loading Next Video", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        },
        showVideoProgressIndicator : true
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Inside Buil");
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20,0),
                child: Text("Select Playlist to Play",textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[900]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
//                    hint: Text("Select Playlist to Play"),
                    value: dropdownValue,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                        color: Colors.indigo[900]
                    ),
                    items: <String> [
                      "Know About Coronavirus",
                      "PM Narendra Modi on Coronavirus",
                      "Learn COVID-19 Management by MoHFW"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                    onChanged: (String newValue) {
                      String temp;
                      if (_controller.value.isReady) {
                        print("Selected Dropdown : $newValue");
//                        _controller.pause();
                        temp = dropdownValue;
                        dropdownValue = newValue;
                        print("VideoList before Clear and check : ${videoList.length}");
                        if(newValue != temp){
                          print("VideoList before Clear : ${videoList1.length} + ${videoList2.length} + ${videoList3.length}");
                          videoList.clear();
                          print("VideoList after Clear : ${videoList1.length} + ${videoList2.length} + ${videoList3.length}");
                          if(newValue == "Know About Coronavirus") {
                            currentPlayList = 1;
                            videoList.addAll(videoList1);
                            print("VideoList after Update : ${videoList.length}");
                          }else if(newValue == "PM Narendra Modi on Coronavirus") {
                            currentPlayList = 2;
                            videoList.addAll(videoList2);
//                            print("VideoList after Update : ${videoList.length}");
                          }else if(newValue == "Learn COVID-19 Management by MoHFW") {
                            currentPlayList = 3;
                            videoList.addAll(videoList3);
//                            print("VideoList after Update : ${videoList.length}");
                          }
                          initVideoId = videoList[0].id;
                          currIndex = 0;
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.width * 0.60,
            color: Colors.black,
            child: ((videoList1.isNotEmpty || videoList2.isNotEmpty || videoList3.isNotEmpty)) ?
            Container(
                child: buildVideoPlayer()
            ):
            Container(
                child: Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.white,),
                )
            ),
          ),
        ),
      ],
    );
  }
}