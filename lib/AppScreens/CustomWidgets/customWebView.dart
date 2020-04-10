import 'package:flutter/material.dart';
import 'package:modular_login/Models/UrlDataModel.dart';
import 'package:webview_media/webview_flutter.dart' as w;


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
          w.WebView(
            initialUrl : _data.url,
            javascriptMode: w.JavascriptMode.unrestricted,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.075,
            child: AppBar(
              title: Text("Live World Stats"),
            ),
          ),
        ],
      ),
    );
  }
}
