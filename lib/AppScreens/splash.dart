import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FeedScreens/HomePage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    _checkForSession().then((status) {
          if (status)
            _navigate();
    });
  }


  Future<bool> _checkForSession() async {
    await Future.delayed(Duration(seconds: 3), () {});
    return true;
  }

  var email;

  void _navigate() async {
//    WidgetsFlutterBinding.ensureInitialized();
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
          body: Center(
            child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Image.asset(coronaGIF),
            ),
          ),
        ),
      ),
    );
  }
}
