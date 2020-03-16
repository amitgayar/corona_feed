import 'package:flutter/material.dart';

class LoginLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blue[50],
            appBar: AppBar(
              title: const Text('FEED'),
            ),
            body: Text("Sign in with google pressed")
        )
    );
  }
}