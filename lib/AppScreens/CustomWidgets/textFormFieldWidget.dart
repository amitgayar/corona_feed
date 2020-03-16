import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {

  final int type ;
  final TextEditingController myController;

  TextFormFieldWidget({
    this.type,
    this.myController
  });

  @override
  State<StatefulWidget> createState() {
    return TextFormFieldWidgetState();
  }
}

class TextFormFieldWidgetState extends State<TextFormFieldWidget>{

  String errMsg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.type < 4) ? 70 : 55,
      width: 150,
      child: TextFormField(
        decoration: InputDecoration(
          errorText: errMsg,
          labelText: getLabel(),
          labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),gapPadding: 5),
        ),
        style: TextStyle(
            fontSize: 17),
        keyboardType: getTextInputType(),
        controller: widget.myController,
        onChanged: (text){
          setState(() {
            errMsg  = validate(text);
          });
        },
//        TODO
//        onFieldSubmitted: ,
        maxLengthEnforced: true,
        maxLength: getMaxLength(),
        obscureText: (widget.type == 4 || widget.type == 5) ? true: false,
      ),
    );
  }

  String getLabel() {
    switch(widget.type){
      case 1 : return "Enter Mobile"; break;
      case 2 : return "Enter Email "; break;
      case 3 : return "Enter User Name"; break;
      case 4 : return "Enter Password"; break;
      case 5 : return "Enter OTP"; break;
      default : return null;
    }
  }

  String validate(String val) {
    if(val.isEmpty)  return "Can't be Empty";
    else if (val.length < 3)      return "Can't be less than 3";
    else if (val.length > 6 && widget.type == 5)      return "Can't be greater than 6";
    else if (val.length < 8 && widget.type == 4)      return "Can't be less than 8";
    else if(widget.type == 1 && val.length != 10) return "must be of 10 digits";
    else if ((!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z]+\.[a-z][a-z][a-z]+").hasMatch(val)) && widget.type == 2)
      return "Invalid Email";
    else return null;
  }

  int getMaxLength() {
    switch(widget.type){
      case 1 : return 10; break;
      case 2 : return 25; break;
      case 3 : return 15; break;
      default : return null;
    }
  }

  TextInputType getTextInputType (){
    if(((widget.type == 1 || widget.type == 5) && widget.type <6 )) return TextInputType.phone;
    else if(widget.type == 2 && widget.type < 6) return TextInputType.emailAddress;
    else return TextInputType.text;
  }

}