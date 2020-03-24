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

class WebView extends StatelessWidget {

  UrlData _data;

  @override
  Widget build(BuildContext context) {

    RouteSettings settings = ModalRoute.of(context).settings;
    _data = settings.arguments;

    print("URL IS " + _data.url);
    print("TITLE IS " + _data.title);

    return WebviewScaffold(
      appBar: AppBar(
        title: Text(_data.title),
      ),
      url: _data.url,
      withZoom: true,
    );
  }
}