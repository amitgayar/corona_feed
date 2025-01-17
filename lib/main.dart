import 'package:flutter/material.dart';
import 'AppScreens/CustomWidgets/customWebView.dart';
import 'AppScreens/Login/login.dart';
import 'AppScreens/Login/Signup.dart';
import 'AppScreens/FeedScreens/HomePage.dart';
import 'AppScreens/FeedScreens/MyFeedScreen.dart';
import 'AppScreens/Login/ResetPassword.dart';
import 'AppScreens/FeedScreens/WebView.dart';
import 'AppScreens/splash.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Title of the application.
      title: 'Corona Feed',
      // Theme of the application.
      theme: ThemeData(
        primaryColor: Color(0xffea70b1),
        textTheme: TextTheme(
          title : TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          body1: TextStyle(fontSize: 12, color: Color(0xffea70b1)),
          button: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )
      ),
      home: Splash(),
      routes: {
        '/Login'    : (context) => Login(),
        '/SignUp'   : (context) => SignUp(),
        '/PasswordReset': (context) => ResetPassword(),
        '/HomePage' : (context) => HomePage(),
        '/webView'  : (context) => WebView(),
        '/customWebView'  : (context) => CustomWebView(),
        '/Myfeeds'  : (context) => MyFeed()
      },
    );
  }
}