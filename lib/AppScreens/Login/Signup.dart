import 'package:flutter/material.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import '../../constants/constants.dart';
import '../../Services/AuthWithEmailPasswd.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {

  static Widget logo = Image.asset(coronaGIF);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  static TextEditingController emailTextController = TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();

  final AuthService _auth = AuthService();
  bool isLoading = false;

  void registerUser() async {
    dynamic result;
    try {
      result = await _auth.registerWithEmailAndPassword(emailTextController.text, passwordTextController.text);
      if(result != null){
        setState(() {
          isLoading = false;
          emailTextController.clear();
          passwordTextController.clear();
        });
        Toast.show("Registered Successfully, Verification Email Sent.",context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.popAndPushNamed(context, '/Login');
      }
    } catch (e) {
      setState(() {
        String errMsg = fireBaseErrorMessage(result.toString());
        isLoading = false;
        Toast.show(errMsg, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        print("Inside Signup Catch: " + result.toString());
      });
    }
  }

  void googleSignIn() async {
    try {
      await signInWithGoogle().then((result) {
        Toast.show("Logged In SuccessFully", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.popAndPushNamed(context, '/HomePage', arguments: [2, name, imageUrl,email]);
      });
    } catch (e) {
      print("In Google Sign in Login" + e.toString());
    }
  }

  String errMsg1, errMsg2 ;

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
                  child: SignUp.logo
              ),
            ),  //LOGO
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 20),
              child: Material(
                color: Colors.white,
                elevation: 3.0,
                borderRadius: BorderRadius.circular(7.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                          "SIGN UP",
                          style: new TextStyle(
                            fontSize: 15,
                            color: baseColor,
                            fontWeight: FontWeight.bold,
                          )
                      ),   //SIGN UP TEXT
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
                        controller: emailTextController,
                        onChanged: (text){
                          setState(() {
                            errMsg1  = validate(text,2);
                          });
                        },
                      ),   //EMAIL TEXT FIELD
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(
                          errorText: errMsg2,
                          errorStyle: TextStyle(color: Colors.indigo[900]),
                          labelText: "Enter Password",
                          prefixIcon: Icon(Icons.lock,color: baseColor,),
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
                        keyboardType: TextInputType.text,
                        controller: passwordTextController,
                        onChanged: (text){
                          setState(() {
                            errMsg2 = validate(text,4);
                          });
                        },
                        obscureText: true,
                      ),   //PASSWORD TEXT FIELD
                      SizedBox(height: 20,),
                      (isLoading) ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircularProgressIndicator(backgroundColor: baseColor),
                        ],
                      ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                            textColor: Colors.white,
                            color: baseColor,
                            child: Text("SIGN UP"),
                            onPressed: ()  {
                              setState(() {
//                                print(emailTextController.text + " " + passwordTextController.text);
                                if (emailTextController.text.isEmpty)
                                  Toast.show("Email cannot be Empty",context,
                                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                else if (passwordTextController.text.isEmpty)
                                  Toast.show("Password cannot be Empty",context,
                                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                else {
                                  isLoading = true;
                                  registerUser();
                                }
                              });
                            },
                          ),
                        ],
                      ),   //SIGN UP BUTTON
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {googleSignIn();},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage(
                      "assets/google_logo.png"),
                      height: 15.0
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                    ),
                  )
                ],
              ),
            ), //Google SignIn Button
            FlatButton(
              onPressed: () {Navigator.pushNamed(context, '/Login');},
              child: Text(
                'Already have an Account ? Login ',
                style: TextStyle(
                  color: baseColor,
                ),  //Already Registered
              )
            ),
          ],
        ),
      ),
    );
  }
}