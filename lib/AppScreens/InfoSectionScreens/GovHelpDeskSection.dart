import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GovHelpDeskSection extends StatefulWidget {
  @override
  _GovHelpDeskSectionState createState() => _GovHelpDeskSectionState();
}

class _GovHelpDeskSectionState extends State<GovHelpDeskSection> {

  callUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Gov helpdesk contacts
  static List _contacts = [
    {"inText" : "011-23978046 or 1075", "outText" : "Helpline Number" ,"url": "tel:1075",
      "inColor" : Color.fromRGBO(253, 195, 204, 1) , "bottomColor" : Color.fromRGBO(208, 0, 24, 1)},
    {"inText" : "ncov2019@gov.in", "outText" : "Email Id","url": "mailto:ncov2019@gov.in",
      "inColor" : Color.fromRGBO(218, 209, 246, 1) , "bottomColor" : Color.fromRGBO(97, 54, 185, 1)},
    {"inText" : "Whatsapp : 91-9013151515", "outText" : "MyGov Corona Live HelpDesk","url": "https://api.whatsapp.com/send?phone=919013151515&text=&source=&data=",
      "inColor" : Color.fromRGBO(214, 246, 209, 1) , "bottomColor" : Color.fromRGBO(48, 178, 36, 1)},
    {"inText" : "Corona NewsDesk On Telegram", "outText" : "MyGov Corona Live HelpDesk","url": "https://t.me/MyGovCoronaNewsDesk",
      "inColor" : Colors.blue[200] , "bottomColor" : Colors.blue[800]},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        items: _contacts.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Container(
                        color: i["inColor"],
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(i["inText"],
                              style: TextStyle(
                                color: i["bottomColor"],
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
                        color: i["bottomColor"],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(i["outText"],
                              style: TextStyle(
                                color: i["inColor"],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }).toList(),
        autoPlay: false,
        enlargeCenterPage: true,
      ),
    );
  }

}