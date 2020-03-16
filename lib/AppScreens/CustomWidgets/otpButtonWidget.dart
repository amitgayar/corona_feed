import 'package:flutter/material.dart';

class OtpButtonWidget extends StatefulWidget {

  final int type ;   // 1 for send otp , 2 for resend otp

  OtpButtonWidget({
    this.type,
  });

  @override
  State<StatefulWidget> createState() {
    return OtpButtonWidgetState();
  }
}

class OtpButtonWidgetState extends State<OtpButtonWidget>{

  @override
  Widget build(BuildContext context) {

    return Center(
          child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(getText()),
            onPressed: () {
              generateOtp();
            },
          ),
        );
  }

  // TODO ADD Timer

  void generateOtp() {}

  String getText() {
    if(widget.type == 1)
      return "SEND OTP";
    else
      return "RESEND OTP";
  }

}