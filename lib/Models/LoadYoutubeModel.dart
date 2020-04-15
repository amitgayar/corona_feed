import 'package:modular_login/Services/youtubeApiService.dart';
import 'package:modular_login/constants/globals.dart';

class LoadYoutube {

  loadPlayerVideos() async {
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
  }

  loadVideoList() async{
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
  }

}