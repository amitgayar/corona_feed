import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {

  final int type;

  LoginButtonWidget({
    this.type
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        focusColor: Colors.blueAccent[50],
        child: Container(
            child: Text(getText(type)),
        ),
        onPressed: () {
          if(type == 4 || type == 0) validateCredentials();
          else Navigator.pushNamed(context, '/otpLogin');
          },
      ),
    );
  }

  void validateCredentials() {}

  String getText(int type) {
    if(type == 5) return "LOGIN WITH OTP" ;
    else return "SIGN IN";
  }

}


