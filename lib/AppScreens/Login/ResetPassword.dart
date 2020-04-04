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
          backgroundColor: bgColor,
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ResetPassword.logo
                ),
              ), //LOGO
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Material(
                  color: Colors.white,
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(7),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Text(
                            "RESET PASSWORD",
                            style: new TextStyle(
                              fontSize: 15,
                              color: baseColor,
                              fontWeight: FontWeight.bold,
                            )
                        ), //RESET PASSWORD TEXT
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                            errorText: errMsg1,
                            errorStyle: TextStyle(color: Colors.indigo[900]),
                            labelText: "Enter Email",
                            prefixIcon: Icon(Icons.email,color: baseColor),
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
                          controller: _emailTextController,
                          onChanged: (text) {
                            setState(() {
                              errMsg1 = validate(text, 2);
                            });
                          },
                        ), //EMAIL TEXT FIELD
                        SizedBox(height: 20,),
                        (isLoading) ?
                        CircularProgressIndicator(backgroundColor: baseColor):
                        RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          color: baseColor,
                          textColor: Colors.white,
                          child: Text("SEND PASSWORD RESET LINK"),
                          onPressed: () {
                            setState(() {
                              print("Sending Password reset Link for" + _emailTextController.text);
                              isLoading = true;
                              sendPasswordResetLink();
                            });
                          },
                        ), //RESET PASSWORD BUTTON
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
}