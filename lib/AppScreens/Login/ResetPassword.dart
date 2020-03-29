import 'package:flutter/material.dart';
import 'package:modular_login/Services/AuthWithEmailPasswd.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

class ResetPassword extends StatefulWidget {

  static Widget logo = Image.asset("assets/coronaVirus.gif");

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  static TextEditingController _emailTextController = TextEditingController();

  final AuthService _auth = AuthService();

  String errMsg1;
  bool isLoading = false;

  void sendPasswordResetLink() async{
      try {
        await _auth.sendPasswordResetEmail(_emailTextController.text);
        print("Password Reset Link Sent Successfully");
        Toast.show("Password Reset Link Sent Successfully", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        setState(() {
          isLoading = false;
          _emailTextController.clear();
        });
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.popAndPushNamed(context, '/Login');
      } catch (e) {
        setState(() {
          print("Inside Reset Password Catch: " + e.toString());
          Toast.show("Network Error Occured", context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        });
      }
  }


  @override
  Widget build(BuildContext context) {
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
                    child: ResetPassword.logo
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
                            "RESET PASSWORD",
                            style: new TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ), //RESET PASSWORD TEXT
                      Padding(
                        padding: const EdgeInsets.only(top: 35, left: 25.0, right: 25,bottom: 20),
                        child: SizedBox(
                          height: 70,
                          width: 230,
                          child: TextFormField(
                            decoration: InputDecoration(
                              errorText: errMsg1,
                              labelText: "Enter Email",
                              labelStyle: TextStyle(fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), gapPadding: 5),
                            ),
                            style: TextStyle(fontSize: 17),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            onChanged: (text) {
                              setState(() {
                                errMsg1 = validate(text, 2);
                              });
                            },
                          ),
                        ),
                      ), //EMAIL TEXT FIELD
                      (isLoading) ? Padding(
                        padding: const EdgeInsets.only(bottom : 35.0),
                        child: CircularProgressIndicator(),
                      ): Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          focusColor: Colors.blueAccent[50],
                          child: Text("SEND PASSWORD RESET LINK"),
                          onPressed: () {
                            setState(() {
                              print("Sending Password reset Link for" + _emailTextController.text);
                              isLoading = true;
                              sendPasswordResetLink();
                            });
                          },
                        ),
                      ), //RESET PASSWORD BUTTON
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