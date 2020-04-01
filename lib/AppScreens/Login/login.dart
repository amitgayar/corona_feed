import 'package:flutter/material.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  static Widget logo = Image.asset("assets/coronaVirus.gif");

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static TextEditingController emailTextController = TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();

  final AuthService _auth = AuthService();

  String errMsg1, errMsg2;

  bool isLoading = false;
  bool isAccountVerified = true;

  void authenticateUser() async {
    dynamic result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          emailTextController.text, passwordTextController.text);
      if (result.email != null) {
        print(result.email + " Authenticated Successfully");
        Toast.show("Login Successful", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        String userName = emailTextController.text;
        setState(() {
          emailTextController.clear();
          passwordTextController.clear();
        });
        print("Inside Authentication " + userName);
        Navigator.popAndPushNamed(context, '/HomePage', arguments: userName);
      }
    } catch (e) {
      setState(() {
        String errMsg = fireBaseErrorMessage(result.toString());
        isLoading = false;
        print("Inside Login Catch: " + result.toString());
        Toast.show(errMsg, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      });
    }
  }

  void googleSignIn() async {
    try {
      await signInWithGoogle().then((result) {
        Toast.show("Logged In SuccessFully", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.popAndPushNamed(context, '/HomePage',
            arguments: [2, name, imageUrl, email]);
      });
    } catch (e) {
      print("In Google Sign in Login" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffefcff),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Container(width: 100, height: 165, child: Login.logo),
            ), //LOGO
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 15, right: 15, bottom: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.height,
                child: Container(
//                    color: Colors.white,
                  color: Color(0xfffefcff),
//                    elevation: 3.0,
//                    borderRadius: BorderRadius.circular(7.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 15, right: 15, bottom: 10),
                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            errorText: errMsg1,
                            prefixIcon: Icon(
                              Icons.email,
                              size: 25,
                              color: Colors.black45,
                            ),
                            labelText: "Enter Email",
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                          ),
                          style: TextStyle(fontSize: 17),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailTextController,
                          onChanged: (text) {
                            setState(() {
                              errMsg1 = validate(text, 2);
                            });
                          },
                        ),
                        Container(
                          height: 20,
                        ), // L TEXT FIELD
                        TextFormField(
                          decoration: InputDecoration(
                            errorText: errMsg2,
                            prefixIcon: Icon(
                              Icons.lock,
//                                                 size: 25,
//                                                 color: Color(0xffea70b1),
                              color: Colors.black45,
                            ),
                            labelText: "Enter Password",
                            labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                          ),
                          style: TextStyle(fontSize: 17),
                          keyboardType: TextInputType.text,
                          controller: passwordTextController,
                          onChanged: (text) {
                            setState(() {
                              errMsg2 = validate(text, 4);
                            });
                          },
                          obscureText: true,
                        ),
                        Container(
                          height: 8,
                        ), // L TEXT FIELD
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/PasswordReset');
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffea70b1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                        ), // L TEXT FIELD
                        (isLoading)
                            ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color(0xffea70b1)),
                              value: null,
                              backgroundColor: Colors.white,
                              //                              strokeWidth: 2.0,
                            )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      textColor: Colors.white,
                                      color: Color(0xffea70b1),
//                          focusColor: Colors.blueAccent[50],
                                      child: Container(
                                        child: Text(
                                          "LOGIN",
                                          //                                            style: TextStyle(color: Colors.blueAccent),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
//                              print(emailTextController.text + " " + passwordTextController.text);
                                          isLoading = true;
                                          authenticateUser();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ), //LOGIN BUTTON
                        //Register
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                googleSignIn();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(),
                    ),
                  )
                ],
              ),
            ), //Google SignIn Button
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/SignUp');
              },
              focusColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an Account ?",
                    style: TextStyle(
                      fontSize: 12,
                      //                        color: Color(0xffea70b1),
                    ),
                  ),
                  Text(
                    ' Sign Up ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffea70b1),
                    ),
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
