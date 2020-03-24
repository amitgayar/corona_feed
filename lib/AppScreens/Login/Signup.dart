import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../Models/UserModel.dart';
import '../../Services/AuthWithEmailPasswd.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {

  static Widget logo = Image.asset(CoronaGIF);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  User user ;

  static int userTypeCode = emailID ;
  static int passwordTypeCode = password ;

  static TextEditingController emailTextController = TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();

  final AuthService _auth = AuthService();

  bool isLoading = false;

  void registerUser() async {
    dynamic result;
    try {
      result = await _auth.registerWithEmailAndPassword(emailTextController.text, passwordTextController.text);
      if(result.email != null){
        setState(() {
          isLoading = false;
          emailTextController.clear();
          passwordTextController.clear();
        });
        Toast.show("Registered Successfully, Please Verify your Email to continue.",context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.popAndPushNamed(context, '/Login');
      }
    } catch (e) {
      setState(() {
        String errMsg = firebaseErrorMessage(result.toString());
        isLoading = false;
        print("Inside Signup Catch: " + result.toString());
        Toast.show(errMsg, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      });
    }
  }

  String errMsg1, errMsg2 ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:55),
              child: Container(
                  width: 100,
                  height: 165,
                  child: SignUp.logo
              ),
            ),  //LOGO
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 25,right: 25),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                          "SIGN UP",
                          style: new TextStyle(
                            fontSize: 30,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),   //SIGN UP TEXT
                    Padding(
                      padding: const EdgeInsets.only(top: 15,left : 35.0,right: 35),
                      child: SizedBox(
                        height: 70,
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(
                            errorText: errMsg1,
                            labelText: "Enter Email",
                            labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),gapPadding: 5),
                          ),
                          style: TextStyle(fontSize: 17),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailTextController,
                          onChanged: (text){
                            setState(() {
                              errMsg1  = validate(text,2);
                            });
                          },
                        ),
                      ),
                    ),   //EMAIL TEXT FIELD
                    Padding(
                      padding: const EdgeInsets.only(top: 15,left : 35.0,right: 35),
                      child: SizedBox(
                        height: 70,
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(
                            errorText: errMsg2,
                            labelText: "Enter Password",
                            labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),gapPadding: 5),
                          ),
                          style: TextStyle(fontSize: 17),
                          keyboardType: TextInputType.text,
                          controller: passwordTextController,
                          onChanged: (text){
                            setState(() {
                              errMsg2 = validate(text,4);
                            });
                          },
                          obscureText: true,
                        ),
                      ),
                    ),   //PASSWORD TEXT FIELD
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 25),
                      child: (isLoading) ? CircularProgressIndicator(): RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        focusColor: Colors.blueAccent[50],
                        child: Container(
                          child: Text("SIGN UP"),
                        ),
                        onPressed: ()  {
                          setState(() {
                            isLoading = true;
                            print(emailTextController.text + " " + passwordTextController.text);
                            registerUser();
                          });
                        },
                      ),
                    ),   //SIGN UP BUTTON
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