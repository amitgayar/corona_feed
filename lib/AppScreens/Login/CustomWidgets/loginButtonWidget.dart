import 'package:flutter/material.dart';
import '../../Services/AuthWithEmailPasswd.dart';

class LoginButtonWidget extends StatefulWidget {

  int type;
  String email;
  String password;

  LoginButtonWidget( int type, String email, String password){
    this.type = type;
    this.email = email;
    this.password = password;
  }

  @override
  _LoginButtonWidgetState createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        focusColor: Colors.blueAccent[50],
        child: Container(
            child: Text(getText(widget.type)),
        ),
        onPressed: () {
          if(widget.type == 4 || widget.type == 0) validateCredentials(widget.email,widget.password);
          else Navigator.pushNamed(context, '/otpLogin');
          },
      ),
    );
  }

  String getText(int type) {
    if(type == 5) return "LOGIN WITH OTP" ;
    else return "SIGN IN";
  }

  void validateCredentials(String email, String password) async {
//    TODO
//    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
//    print(email + " " + password);
    dynamic result = await _auth.signInWithEmailAndPassword("asd@gmail.com", "12345678");
    if(result == null)
      print("Invalid Credentials");
    else
      Navigator.pushNamed(context, '/LoginLanding');
  }
}