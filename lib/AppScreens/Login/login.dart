import 'package:flutter/material.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

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

  void authenticateUser() async {
    dynamic result;
    try {
      result = await _auth.signInWithEmailAndPassword(emailTextController.text, passwordTextController.text);
      if (result.email != null) {
        print(result.email + " Authenticated Successfully");
        Toast.show("Login Successful", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
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
        Toast.show(errMsg, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      });
    }
  }

  void googleSignIn() async {
    try {
    await signInWithGoogle().then((result) {
        Toast.show("Logged In SuccessFully", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.popAndPushNamed(context, '/HomePage', arguments: [2, name, imageUrl,email]);
      });
    } catch (e) {
      print("In Google Sign in Login" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context){
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Login.logo
                ),
              ), //LOGO
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 20),
                child: Material(
                  color: Colors.white,
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(7.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            errorText: errMsg1,
                            errorStyle: TextStyle(color: Colors.indigo[900]),
                            prefixIcon: Icon(Icons.email,color: baseColor,),
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
                                borderSide: BorderSide(color: baseColor),
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
                            prefixIcon: Icon(Icons.lock, color: baseColor),
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
                                borderSide: BorderSide(color: baseColor),
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
              FlatButton(
                onPressed: () {Navigator.pushNamed(context, '/SignUp');},
                child: Text(
                  'Don\'t have an Account ? Sign Up ',
                  style: TextStyle(
                    color: baseColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

}