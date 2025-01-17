import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/GovHelpDeskSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/MythsInfoSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/SymptomsInfoSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/YoutubeInfoSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/statsInfoSection.dart';
import 'package:modular_login/Models/getStatsModel.dart';
import 'package:modular_login/constants/constants.dart';

class InfoTabWidget extends StatefulWidget {

  @override
  _InfoTabWidgetState createState() => _InfoTabWidgetState();
}

class _InfoTabWidgetState extends State<InfoTabWidget> {
  @override
  Widget build(BuildContext context) {

    GetStatistics _getStats = new GetStatistics();

//    return ListView.builder(
//          itemCount: 5,
//          itemBuilder: (BuildContext context, int index) {
//            if(index == 0){
//              return Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(10,15,0,10),
//                    child: Text("CoronaVirus Statistics",
//                        style: new TextStyle(
//                            fontSize: 17,
//                            color: baseColor,
//                            fontWeight: FontWeight.w900)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
//                    child: Material(
//                      color: Colors.white,
//                      elevation: 2.0,
//                      borderRadius: BorderRadius.circular(7),
//                      shadowColor: baseColor,
//                      child : StatsInfoSection(),
//                    ),
//                  ),
//                ],
//              );
//            } else if(index == 1){
//              return Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(10,15,0,10),
//                    child: Text("Understand Coronavirus",
//                        style: new TextStyle(
//                            fontSize: 17,
//                            color: baseColor,
//                            fontWeight: FontWeight.w900)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
//                    child: Material(
//                      color: Colors.white,
//                      elevation: 2.0,
//                      borderRadius: BorderRadius.circular(7),
//                      shadowColor: baseColor,
//                      child : SymptomInfoSection(),
//                    ),
//                  ),
//                ],
//              );
//            } else if(index == 2){
//              return Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(10,15,0,10),
//                    child: Text("Myth Busters",
//                        style: new TextStyle(
//                            fontSize: 17,
//                            color: baseColor,
//                            fontWeight: FontWeight.w900)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
//                    child: Material(
//                      color: Colors.white,
//                      elevation: 2.0,
//                      borderRadius: BorderRadius.circular(7),
//                      shadowColor: baseColor,
//                      child : MythsInfoSection(),
//                    ),
//                  ),
//                ],
//              );
//            } else if(index == 3){
//              return Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(10,15,0,10),
//                    child: Text("CoronaVirus Videos",
//                        style: new TextStyle(
//                            fontSize: 17,
//                            color: baseColor,
//                            fontWeight: FontWeight.w900)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
//                    child: Material(
//                      color: Colors.white,
//                      elevation: 2.0,
//                      borderRadius: BorderRadius.circular(7),
//                      shadowColor: baseColor,
//                      child : YoutubeInfoSection(),
//                    ),
//                  ),
//                ],
//              );
//            } else if(index == 4 && _getStats.inIndia){
//              return Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(10,15,0,10),
//                    child: Text("Government Helpdesk",
//                        style: new TextStyle(
//                            fontSize: 17,
//                            color: baseColor,
//                            fontWeight: FontWeight.w900)),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(10,0,10,10),
//                    child: Material(
//                      color: Colors.white,
//                      elevation: 2.0,
//                      borderRadius: BorderRadius.circular(7),
//                      shadowColor: baseColor,
//                      child : GovHelpDeskSection(),
//                    ),
//                  ),
//                ],
//              );
//            } else {
//              return Container();
//            }
//          });

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10,15,0,10),
          child: Text("CoronaVirus Statistics",
              style: new TextStyle(
                  fontSize: 17,
                  color: baseColor,
                  fontWeight: FontWeight.w900)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,0),
          child: Material(
            color: Colors.white,
            elevation: 2.0,
            borderRadius: BorderRadius.circular(7),
            shadowColor: baseColor,
            child : StatsInfoSection(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,15,0,10),
          child: Text("Understand Coronavirus",
              style: new TextStyle(
                  fontSize: 17,
                  color: baseColor,
                  fontWeight: FontWeight.w900)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,0),
          child: Material(
            color: Colors.white,
            elevation: 2.0,
            borderRadius: BorderRadius.circular(7),
            shadowColor: baseColor,
            child : SymptomInfoSection(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,15,0,10),
          child: Text("Myth Busters",
              style: new TextStyle(
                  fontSize: 17,
                  color: baseColor,
                  fontWeight: FontWeight.w900)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,0),
          child: Material(
            color: Colors.white,
            elevation: 2.0,
            borderRadius: BorderRadius.circular(7),
            shadowColor: baseColor,
            child : MythsInfoSection(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,15,0,10),
          child: Text("CoronaVirus Videos",
              style: new TextStyle(
                  fontSize: 17,
                  color: baseColor,
                  fontWeight: FontWeight.w900)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,0),
          child: Material(
            color: Colors.white,
            elevation: 2.0,
            borderRadius: BorderRadius.circular(7),
            shadowColor: baseColor,
            child : YoutubeInfoSection(),
          ),
        ),
        (_getStats.inIndia) ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10,15,0,10),
              child: Text("Government Helpdesk",
                  style: new TextStyle(
                      fontSize: 17,
                      color: baseColor,
                      fontWeight: FontWeight.w900)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,0,10,10),
              child: Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.circular(7),
                shadowColor: baseColor,
                child : GovHelpDeskSection(),
              ),
            ),
          ],
        ) : Container(),
      ],
    );
  }
}