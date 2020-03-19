import 'package:flutter/material.dart';
import '../CustomWidgets/textIdWidget.dart';
import '../CustomWidgets/textFormFieldWidget.dart';
import '../CustomWidgets/loginButtonWidget.dart';
import '../CustomWidgets/OtpButtonWidget.dart';

class OtpLogin extends StatefulWidget {
//  OtpLogin({Key key}) : super(key: key);

  bool state = true;

  @override
  _OtpLogin createState() => _OtpLogin();
}

class _OtpLogin extends State<OtpLogin> {
  @override
  Widget build(BuildContext context) {

    //  final mobileNumber = 1; final emailID = 2; final userName = 3; final password = 4; final otp = 5;

    int userTypeCode = 1 , passwordTypeCode = 5 ;
    String mobile = "";
    String otp = "";

    final TextIdWidget mobileText = new TextIdWidget(type:userTypeCode);
    final TextIdWidget otpText = new TextIdWidget(type:passwordTypeCode);

    final TextFormFieldWidget mobileTextField = new TextFormFieldWidget(type:userTypeCode);
    final TextFormFieldWidget otpTextField = new TextFormFieldWidget(type:passwordTypeCode);

    final LoginButtonWidget loginButton = new LoginButtonWidget(0,mobile,otp);   // For Sign In Button on OTP Login PAGE
    final OtpButtonWidget otpButton = new OtpButtonWidget(type : 1);
    final OtpButtonWidget reOtpButton = new OtpButtonWidget(type: 2);

    final Widget logo = Image.asset("assets/icon.png");

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
                  child: logo
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70,left: 25,right: 25),
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:20, left: 30),
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              mobileText
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left : 15.0),
                            child: Column (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                mobileTextField
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:20.0),
                            child: IconButton(
                                icon: Icon(Icons.edit),
                                tooltip: 'Edit Mobile',
                                onPressed: () {
                                  setState(() {
                                    print(widget.state);
                                    widget.state = false;
                                    print(widget.state);
                                  });
                                }
                                ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 30),
                      child: Row (
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              (widget.state) ? otpText : Container()
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left : 35.0),
                            child: Column (
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                (widget.state) ? otpTextField : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top : 10.0,bottom: 25.0),
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          (widget.state) ? Row(children: <Widget>[reOtpButton,SizedBox(width:50),loginButton],) : otpButton
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