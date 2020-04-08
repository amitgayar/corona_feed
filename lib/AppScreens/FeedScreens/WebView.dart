import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class UrlData {
  String url;
  String title;

  UrlData({
    this.url,
    this.title
  });
}

// ignore: must_be_immutable
class WebView extends StatelessWidget {

  UrlData _data;

  @override
  Widget build(BuildContext context) {

    RouteSettings settings = ModalRoute.of(context).settings;
    _data = settings.arguments;

    return WebviewScaffold(
      appBar: AppBar(
        title: Text(
          _data.title,
          style: TextStyle(
              fontWeight: FontWeight.normal),
        ),
      ),
      url: _data.url,
      withZoom: true,
    );
  }
}