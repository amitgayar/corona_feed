import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/Login/Signup.dart';
import 'AppScreens/FeedScreens/HomePage.dart';
import 'AppScreens/Login/login.dart';
import 'AppScreens/FeedScreens/WebView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title of the application.
      title: 'Login',
        // Theme of the application.
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomePage(),
//      Login(),
      routes: {
        '/Login'    : (context) => Login(),
        '/SignUp'   : (context) => SignUp(),
        '/HomePage' : (context) => HomePage(),
        '/webView'  : (context) => WebView(),
      },
    );
  }
}