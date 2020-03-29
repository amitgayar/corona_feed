import 'package:flutter/material.dart';
import 'package:modular_login/Services/google_sign_in_auth.dart';
import '../../constants/constants.dart';
import '../../Services/AuthWithEmailPasswd.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {

  static Widget logo = Image.asset(CoronaGIF);

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

  void googleSignIn() {
    signInWithGoogle().whenComplete(() async {
      Toast.show("Logged IN SuccessFully", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.popAndPushNamed(context, '/HomePage', arguments: [1, name, imageUrl]);
    });
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
                    (isLoading) ? Padding(
                      padding: const EdgeInsets.only(top: 7.0,bottom: 7),
                      child: CircularProgressIndicator(),
                    ): Padding(
                      padding: const EdgeInsets.only(top: 7.0,bottom: 7),
                      child: RaisedButton(
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
                    SizedBox(
                      width: 190,
                      child: OutlineButton(
                        onPressed: () {googleSignIn();},
                        borderSide: BorderSide(color: Colors.blue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage(
                                "assets/google_logo.png"),
                                height: 15.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ), //Google SignIn Button
                    Padding(
                      padding: const EdgeInsets.only(top: 5,bottom: 20),
                      child: SizedBox(
                        height: 25,
                        width: 210,
                        child: OutlineButton(
                          onPressed: () {Navigator.pushNamed(context, '/Login');},
                          borderSide: BorderSide(color: Colors.white),
                          splashColor: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Already have an Account ? Login ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),   //Already Registered
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