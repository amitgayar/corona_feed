import 'package:flutter/material.dart';

class TextIdWidget extends StatelessWidget {

  final int type;

  TextIdWidget({
    this.type
  });

  @override
  Widget build(BuildContext context) {
    return Text(getType(),
        style: TextStyle(
            fontSize: 18,
            color: Colors.pink,
            fontWeight: FontWeight.bold
        )
    );
  }

  String getType() {
    switch(type){
      case 1 : return "Mobile";
      break;
      case 2 : return "Email";
      break;
      case 3 : return "User Name";
      break;
      case 4 : return "Password";
      break;
      case 5 : return "OTP";
      break;
      default: return "Invalid TypeCode";
    }
  }

}