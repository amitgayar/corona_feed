import 'package:flutter/material.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';
import '../../Services/AuthWithEmailPasswd.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {

  static Widget logo = Image.asset(coronaGIF);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  static TextEditingController emailTextController = TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();

  final AuthService _auth = AuthService();
  bool isLoading = false;

  void registerUser() async {
    dynamic result;
    try {
      result = await _auth.registerWithEmailAndPassword(emailTextController.text, passwordTextController.text);
      if(result.uid != null){
        setState(() {
          isLoading = false;
          emailTextController.clear();
          passwordTextController.clear();
        });
        Toast.show("Registered Successfully, Verification Email Sent.",context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.popAndPushNamed(context, '/Login');
      }
    } catch (e) {
      setState(() {
        String errMsg = fireBaseErrorMessage(result.toString());
        isLoading = false;
        print("Inside Signup Catch: " + result.toString());
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

  SharedPreferences sharedPreferences;

  // ignore: non_constant_identifier_names
  saveSharedPreference(Email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', Email);
  }

  String errMsg1, errMsg2 ;

  @override
  Widget build(BuildContext context) {
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 20),
              child: Container(
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                          "SIGN UP",
                          style: new TextStyle(
                            fontSize: 15,
                            color: baseColor,
                            fontWeight: FontWeight.bold,
                          )
                      ),   //SIGN UP TEXT
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          errorText: errMsg1,
                          errorStyle: TextStyle(color: Colors.indigo[900]),
                          labelText: "Enter Email",
                          prefixIcon: Icon(Icons.email,),
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
                        onChanged: (text){
                          setState(() {
                            errMsg1  = validate(text,2);
                          });
                        },
                      ),   //EMAIL TEXT FIELD
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(
                          errorText: errMsg2,
                          errorStyle: TextStyle(color: Colors.indigo[900]),
                          labelText: "Enter Password",
                          prefixIcon: Icon(Icons.lock,),
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
                        onChanged: (text){
                          setState(() {
                            errMsg2 = validate(text,4);
                          });
                        },
                        obscureText: true,
                      ),   //PASSWORD TEXT FIELD
                      SizedBox(height: 20,),
                      (isLoading) ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircularProgressIndicator(backgroundColor: baseColor),
                        ],
                      ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                            textColor: Colors.white,
                            color: baseColor,
                            child: Text("SIGN UP"),
                            onPressed: ()  {
                              if(errMsg1 == null && errMsg2 == null){
                                if (emailTextController.text.isEmpty)
                                  Toast.show("Email cannot be Empty",context,
                                      duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                                else if (passwordTextController.text.isEmpty)
                                  Toast.show("Password cannot be Empty",context,
                                      duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                                else
                                  setState(() {
//                                print(emailTextController.text + " " + passwordTextController.text);
                                    isLoading = true;
                                    registerUser();
                                  });
                              }else{
                                Toast.show("Please resolve field errors to continue",
                                    context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                              }
                            },
                          ),
                        ],
                      ),   //SIGN UP BUTTON
                    ],
                  ),
                ),
              ),
            ),
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
                    'Already have an Account ? ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  InkWell(
                      onTap: () {Navigator.pushNamed(context, '/Login');},
                      child: Text(
                        'Login',
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