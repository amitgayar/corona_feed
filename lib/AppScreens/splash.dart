import 'package:flutter/material.dart';
import '../Models/LoadYoutubeModel.dart';
import '../Models/getStatsModel.dart';
import '../constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FeedScreens/HomePage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  // ignore: non_constant_identifier_names
  saveSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("state","");
    prefs.setString("stateCasesText","");
    prefs.setString("cityCasesText ","");
    prefs.setString("city","");
    prefs.setString("flagLink","https://www.worldometers.info/img/flags/in-flag.gif");
    prefs.setString("countryTotalCases","");
    prefs.setString("countryDeceasedCases","");
    prefs.setString("stateCases","");
    prefs.setString("cityCases","");
    prefs.setString("totalCasesWorld","");
    prefs.setString("deceasedCasesWorld","");
    prefs.setBool("inIndia",false);
  }

  GetStatistics _getStats = new GetStatistics();
  LoadYoutube _loadVideos = new LoadYoutube();

  @override
  void initState(){
    super.initState();

    saveSharedPreference();

    _getStats.getLocation();
    _getStats.getWorldCountryData();
    _getStats.getIndiaData();

    _loadVideos.loadPlayerVideos().whenComplete(()=>  _loadVideos.loadVideoList());

//    _loadVideos._initPlayerVideos().whenComplete(()=>  _loadVideos._loadVideoList());

    _checkForSession().then((status) {
          if (status) _navigate();
    });
  }


  Future<bool> _checkForSession() async {
    await Future.delayed(Duration(seconds: 3), () {});
    return true;
  }

  var email;

  void _navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    (email == null) ?
    Navigator.pushReplacementNamed(context, "/Login") :
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(
    builder: (BuildContext context) => HomePage(email : email))
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Image.asset(coronaGIF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top : 80.0),
                child: Text(
                  appName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Berkshire',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
