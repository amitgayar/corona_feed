import 'package:flutter/material.dart';
import '../CustomWidgets/textIdWidget.dart';
import '../CustomWidgets/textFormFieldWidget.dart';
import '../CustomWidgets/loginButtonWidget.dart';

import 'package:modular_login/Services/google_sign_in_auth.dart';

class Login extends StatefulWidget {

  //  final mobileNumber = 1; final emailID = 2; final userName = 3; final password = 4; final otp = 5;

  static int userTypeCode = 2 , passwordTypeCode = 4 ;

  static TextEditingController emailTextController = TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();


  static Widget logo = Image.asset("assets/icon.png");

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  static String email = Login.emailTextController.text;
  static String password = Login.passwordTextController.text;

  @override
  void initState() {
    super.initState();
    email = Login.emailTextController.text;
    password = Login.passwordTextController.text;
  }

  final TextIdWidget emailText = new TextIdWidget(type:Login.userTypeCode);
  final TextIdWidget passwordText = new TextIdWidget(type:Login.passwordTypeCode);

  final TextFormFieldWidget emailTextField = new TextFormFieldWidget(type:Login.userTypeCode, myController: Login.emailTextController);
  final TextFormFieldWidget passwordTextField = new TextFormFieldWidget(type:Login.passwordTypeCode,myController: Login.passwordTextController);

  final LoginButtonWidget loginButton = new LoginButtonWidget(4,email,password);
  final LoginButtonWidget loginWithOtp = new LoginButtonWidget(5,null,null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
//        appBar: AppBar(
//          title: const Text('LOGIN'),
//        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:55),
              child: SizedBox(
                  width: 165,
                  height: 165,
                  child: Login.logo
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 25,right: 25),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:30, left: 35),
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              emailText
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left : 55.0),
                            child: Column (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                emailTextField
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 35),
                      child: Row (
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              passwordText
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left : 15.0),
                            child: Column (
                              children: <Widget>[
                                passwordTextField
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 25),
                      child: Row (
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              loginButton,
                              loginWithOtp,
                              OutlineButton(
                                onPressed: () {
                                  signInWithGoogle().whenComplete(() /*async*/  {
//                                    String user = await signInWithGoogle();
                                    /*if( user != null) */ Navigator.pushNamed(context, '/LoginLanding');
                                  });
                                  },
                                borderSide: BorderSide(color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(image: AssetImage("assets/google_logo.png"), height: 15.0),
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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