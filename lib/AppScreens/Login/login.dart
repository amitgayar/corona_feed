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
          backgroundColor: Colors.blue[50],
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Container(
                    width: 100,
                    height: 165,
                    child: Login.logo
                ),
              ), //LOGO
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                            "LOGIN",
                            style: new TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ), //LOGIN TEXT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 25.0, right: 25),
                                child: SizedBox(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      errorText: errMsg1,
                                      prefixIcon: Icon(Icons.email,size: 25),
                                      labelText: "Enter Email",
                                      labelStyle: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), gapPadding: 5),
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
                                ),
                              ), //EMAIL TEXT FIELD
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 25.0, right: 25),
                                child: SizedBox(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      errorText: errMsg2,
                                      prefixIcon: Icon(Icons.lock,size: 25),
                                      labelText: "Enter Password",
                                      labelStyle: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), gapPadding: 5),
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
                                ),
                              ), // PASSWORD TEXT FIELD
                          ],
                          ),
                        ],
                      ),     //TextBoxes
                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 35,bottom: 10),
                        child: SizedBox(
                          height: 15,
                          child: OutlineButton(
                            onPressed: () {Navigator.pushNamed(context, '/PasswordReset');},
                            borderSide: BorderSide(color: Colors.white),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      (isLoading) ?
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CircularProgressIndicator(),
                      ) :
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          focusColor: Colors.blueAccent[50],
                          child: Container(
                            child: Text("LOGIN"),
                          ),
                          onPressed: () {
                            setState(() {
//                              print(emailTextController.text + " " + passwordTextController.text);
                              isLoading = true;
                              authenticateUser();
                            });
                          },
                        ),
                      ), //LOGIN BUTTON
                      SizedBox(
                        width: 190,
                        child: OutlineButton(
                          onPressed: () {googleSignIn();},
                          borderSide: BorderSide(color: Colors.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(image: AssetImage(
                                  "assets/google_logo.png"),
                                  height: 15.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ), //Google SignIn Button
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 20),
                        child: SizedBox(
                          height: 25,
                          width: 210,
                          child: OutlineButton(
                            onPressed: () {Navigator.pushNamed(context, '/SignUp');},
                            borderSide: BorderSide(color: Colors.white),
                            focusColor: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Don\'t have an Account ? Sign Up ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //Register
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

}