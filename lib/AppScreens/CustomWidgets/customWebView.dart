import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/FeedScreens/WebView.dart';
import 'package:webview_flutter/webview_flutter.dart' as w;

class CustomWebView extends StatefulWidget {
  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {

  UrlData _data;

  @override
  Widget build(BuildContext context) {

    RouteSettings settings = ModalRoute.of(context).settings;
    _data = settings.arguments;

    return Stack(
      children: <Widget>[
        SafeArea(
          child: w.WebView(
            initialUrl : _data.url,
            javascriptMode: w.JavascriptMode.unrestricted,
          ),
        ),
        Container(
          height: 85,
          child: AppBar(
            title: Text("Live World Stats"),
          ),
        ),
      ],
    );
//      Stack(
//      children: <Widget>[
//        Scaffold(
//          appBar: AppBar(
//            title: Text("Live World Stats"),
//          ),
//        ),
//        WebView(
//          initialUrl: widget.url,
//        ),
//      ],
//    );
  }
}
