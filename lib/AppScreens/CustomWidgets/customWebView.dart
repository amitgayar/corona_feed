import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {

  String url;

  CustomWebView({this.url});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            WebView(
              initialUrl: widget.url,
            ),
            AppBar(
              title: Text("Live World Statistics"),
            ),
          ],
        ),
      ],
    );
  }
}
