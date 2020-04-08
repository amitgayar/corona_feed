import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/FeedScreens/WebView.dart';
import 'package:url_launcher/url_launcher.dart';

class GovHelpDeskSection extends StatefulWidget {
  @override
  _GovHelpDeskSectionState createState() => _GovHelpDeskSectionState();
}

class _GovHelpDeskSectionState extends State<GovHelpDeskSection> {

  callUrl(url) async {
    if (!url.contains("https://t.me/s/MyGovCoronaNewsDesk")) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      UrlData _urlData = new UrlData(url: url,title :"MyGov Corona News Desk");
      Navigator.pushNamed(context, '/webView',arguments: _urlData);
    }
  }

  //Gov helpdesk contacts
  static List _contacts = [
    {"inText" : "011-23978046 \n or \n 1075", "outText" : "Helpline Number" ,"url": "tel:1075",
      "inColor" : Color.fromRGBO(253, 195, 204, 1) , "bottomColor" : Color.fromRGBO(208, 0, 24, 1)},
    {"inText" : "ncov2019@gov.in", "outText" : "Email Id","url": "mailto:ncov2019@gov.in",
      "inColor" : Color.fromRGBO(218, 209, 246, 1) , "bottomColor" : Color.fromRGBO(97, 54, 185, 1)},
    {"inText" : "Whatsapp :\n 91-9013151515", "outText" : "Corona Live Helpdesk","url": "https://api.whatsapp.com/send?phone=919013151515&text=&source=&data=",
      "inColor" : Color.fromRGBO(214, 246, 209, 1) , "bottomColor" : Color.fromRGBO(48, 178, 36, 1)},
    {"inText" : "Corona NewsDesk \n On Telegram", "outText" : "Corona Live Newsdesk","url": "https://t.me/s/MyGovCoronaNewsDesk",
      "inColor" : Colors.blue[200] , "bottomColor" : Colors.blue[800]},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  getCard(_contacts[0])
                ],
              ),
              Column(
                children: <Widget>[
                  getCard(_contacts[1])
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  getCard(_contacts[2])
                ],
              ),
              Column(
                children: <Widget>[
                  getCard(_contacts[3])
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  getCard(contacts) {
    return GestureDetector(
      onTap: () => callUrl(contacts["url"]),
      child: Card(
        elevation: 3.0,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Container(
                color: contacts["inColor"],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(contacts["inText"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: contacts["bottomColor"],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: contacts["bottomColor"],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(contacts["outText"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: contacts["inColor"],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}