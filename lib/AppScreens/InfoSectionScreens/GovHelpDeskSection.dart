import 'package:flutter/material.dart';
import 'package:modular_login/Models/UrlDataModel.dart';
import 'package:url_launcher/url_launcher.dart';

class GovHelpDeskSection extends StatelessWidget {

  callUrl(url,context) async {
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
    { "inText" : "011-23978046 1075" , "outText" : "Helpline Number" , "url" : "",
      "inColor" : Colors.blue[200] , "bottomColor" : Colors.blue[800]},
    { "inText" : "ncov2019@gov.in", "outText" : "Email Id","url": "mailto:ncov2019@gov.in",
      "inColor" : Color.fromRGBO(218, 209, 246, 1) , "bottomColor" : Color.fromRGBO(97, 54, 185, 1)},
    { "inText" : "Whatsapp :\n 91-9013151515", "outText" : "Corona Live Helpdesk","url": "https://api.whatsapp.com/send?phone=919013151515&text=&source=&data=",
      "inColor" : Color.fromRGBO(214, 246, 209, 1) , "bottomColor" : Color.fromRGBO(48, 178, 36, 1)},
    { "inText" : "Corona NewsDesk \n On Telegram", "outText" : "Corona Live Newsdesk","url": "https://t.me/s/MyGovCoronaNewsDesk",
      "inColor" : Color.fromRGBO(253, 195, 204, 1) , "bottomColor" : Color.fromRGBO(208, 0, 24, 1)}];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child:getCallCard(_contacts[0],context)
                ),
                Expanded(
                    child:getCard(_contacts[1],context)
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child:getCard(_contacts[2],context)
                ),
                Expanded(
                    child:getCard(_contacts[3],context)
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  getCard(contacts,context) {
    return GestureDetector(
      onTap: () => callUrl(contacts["url"],context),
      child: Card(
        elevation: 3.0,
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.height/2.3,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
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
                flex: 1,
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
      ),
    );
  }

  getCallCard(contacts,context) {
    return Card(
      elevation: 3.0,
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.height/2.3,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: contacts["inColor"],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap : () => callUrl("tel:" + contacts["inText"].toString().substring(0,12),context),
                          child: Text(
                            contacts["inText"].toString().substring(0,12),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: contacts["bottomColor"],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("OR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : () => callUrl("tel:" + contacts["inText"].toString().substring(12,17),context),
                          child: Text(contacts["inText"].toString().substring(12,17),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: contacts["bottomColor"],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: contacts["bottomColor"],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      contacts["outText"],
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