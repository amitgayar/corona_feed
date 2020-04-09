import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/FeedScreens/WebView.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: 85,
            child: AppBar(
              title: Text("Live World Stats"),
            ),
          ),
          WebviewScaffold(
            url : _data.url,
            ),
        ],
      ),
    );
  }
}
