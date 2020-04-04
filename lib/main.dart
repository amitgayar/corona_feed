import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppScreens/Login/login.dart';
import 'AppScreens/Login/Signup.dart';
import 'AppScreens/FeedScreens/HomePage.dart';
import 'AppScreens/FeedScreens/MyFeedScreen.dart';
import 'AppScreens/Login/ResetPassword.dart';
import 'AppScreens/FeedScreens/WebView.dart';

var email;

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  print(email);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Title of the application.
      title: 'Login',
      // Theme of the application.
      theme: ThemeData(
        primaryColor: Color(0xffea70b1),
        textTheme: TextTheme(
          title : TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          body1: TextStyle(fontSize: 12, color: Color(0xffea70b1)),
          button: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )
      ),
      home: (email == null) ? Login() : HomePage(),
      routes: {
        '/Login'    : (context) => Login(),
        '/SignUp'   : (context) => SignUp(),
        '/PasswordReset': (context) => ResetPassword(),
        '/HomePage' : (context) => HomePage(),
        '/webView'  : (context) => WebView(),
        '/Myfeeds'  : (context) => MyFeed()
      },
    );
  }
}