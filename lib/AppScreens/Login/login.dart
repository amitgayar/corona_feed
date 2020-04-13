import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/YoutubeInfoSection.dart';
import 'package:modular_login/Models/getStatsModel.dart';

import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  static Widget logo = Image.asset(coronaGIF);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  static TextEditingController emailTextController = TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();

  final AuthService _auth = AuthService();

  String errMsg1, errMsg2 ;
  bool isLoading = false;
  bool isAccountVerified = true;

  SharedPreferences sharedPreferences;

  void authenticateUser() async {
    dynamic result;
    try {
      result = await _auth.signInWithEmailAndPassword(emailTextController.text, passwordTextController.text);
      if (result.email != null) {
        saveSharedPreference(result.email);
        print(result.email + " Authenticated Successfully");
        Toast.show("Login Successful", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        String userName = emailTextController.text;
        setState(() {
          emailTextController.clear();
          passwordTextController.clear();
        });
        print("Inside Authentication " + userName);
        Navigator.pushReplacementNamed(context, '/HomePage', arguments: userName);
      }
    } catch (e) {
      setState(() {
        String errMsg = fireBaseErrorMessage(result.toString());
        isLoading = false;
        print("Inside Login Catch: " + result.toString());
        Toast.show(errMsg, context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
      });
    }
  }

  void googleSignIn() async {
    try {
    await signInWithGoogle().then((result) {
        Toast.show("Logged In SuccessFully", context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        saveSharedPreference(email);
        Navigator.popAndPushNamed(context, '/HomePage', arguments: email);
      });
    } catch (e) {
      print("In Google Sign in Login" + e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  saveSharedPreference(Email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', Email);

    prefs.setString("state","");
    prefs.setString("stateCasesText","");
    prefs.setString("cityCasesText ","");
    prefs.setString("city","");
    prefs.setString("flagLink","");
    prefs.setString("countryTotalCases","");
    prefs.setString("countryDeceasedCases","");
    prefs.setString("stateCases","");
    prefs.setString("cityCases","");
    prefs.setString("totalCasesWorld","");
    prefs.setString("deceasedCasesWorld","");
    prefs.setBool("inIndia",false);
  }

  @override
  void initState() {
    super.initState();
    GetStatistics _getStats = new GetStatistics();
    _getStats.getLocation();
    _getStats.getWorldCountryData();
    _getStats.getIndiaData();
  }

  @override
  Widget build(BuildContext context){
      return SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Image.asset(coronaGIF),
                    ),
                  ),
                  Text(
                    appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Berkshire',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ), //LOGO
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 20),
                child: Container(
                  color: bgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top : 10.0),
                        child: Text(
                            "LOGIN",
                            style: new TextStyle(
                              fontSize: 15,
                              color: baseColor,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                errorText: errMsg1,
                                errorStyle: TextStyle(color: Colors.indigo[900]),
                                prefixIcon: Icon(Icons.email,),
                                labelText: "Enter Email",
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: baseColor),
                                    borderRadius: BorderRadius.circular(7)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: baseColor),
                                    borderRadius: BorderRadius.circular(7)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: emailTextController,
                              onChanged: (text) {
                                setState(() {
                                  errMsg1 = validate(text, 2);
                                });
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              decoration: InputDecoration(
                                errorText: errMsg2,
                                errorStyle: TextStyle(color: Colors.indigo[900]),
                                prefixIcon: Icon(Icons.lock, ),
                                labelText: "Enter Password",
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black26
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: baseColor),
                                    borderRadius: BorderRadius.circular(7)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: baseColor),
                                    borderRadius: BorderRadius.circular(7)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                              keyboardType: TextInputType.text,
                              controller: passwordTextController,
                              onChanged: (text) {
                                setState(() {
                                  errMsg2 = validate(text, 4);
                                });
                              },
                              obscureText: true,
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {Navigator.pushNamed(context, '/PasswordReset');},
                              child: Text(
                                'Forgot Password',
                              ),
                            ),
                            (isLoading) ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                CircularProgressIndicator(backgroundColor: baseColor),
                              ],
                            ) :
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                  color: baseColor,
                                  textColor: Colors.white,
                                  child: Text("LOGIN",),
                                  onPressed: () {
                                    setState(() {
//                                  print(emailTextController.text + " " + passwordTextController.text);
                                      isLoading = true;
                                      authenticateUser();
                                    });
                                  },
                                ),
                              ],
                            ), //LOGIN BUTTON
                            //Register
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),   // Login Card
              FlatButton(
                onPressed: () {googleSignIn();},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage(
                        "assets/google_logo.png"),
                        height: 15.0
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        ),
                      )
                  ],
                  ),
                ), //Google SignIn Button
              Padding(
                padding: const EdgeInsets.only(top : 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an Account ? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    InkWell(
                        onTap: () {Navigator.pushNamed(context, '/SignUp');},
                        child: Text(
                          'Sign Up ',
                          style: TextStyle(
                              color: baseColor,
                              fontWeight: FontWeight.w900
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

}