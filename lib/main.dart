import 'package:flutter/material.dart';
import 'AppScreens/Login/login_landing.dart';
import 'AppScreens/Login/login.dart';
import 'AppScreens/Login/OtpLogin.dart';

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
      home: Login(),
      routes: {
        '/otpLogin' : (context) => OtpLogin(),
        '/LoginLanding' : (context) => LoginLanding(),
      },
    );
  }
}