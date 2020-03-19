import 'package:flutter/material.dart';

class LoginLanding extends StatefulWidget {
  @override
  _LoginLandingState createState() => _LoginLandingState();
}

class _LoginLandingState extends State<LoginLanding> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blue[50],
            appBar: AppBar(
              title: const Text('FEED'),
            ),
            body: Text("Sign in Success")
        )
    );
  }
}