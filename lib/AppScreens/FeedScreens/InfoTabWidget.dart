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

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Material(
              color: Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(7),
              shadowColor: baseColor,
              child : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,0),
                    child: Text("CoronaVirus Statistics", textAlign: TextAlign.center,
                style: new TextStyle(
                      fontSize: 15,
                      color: baseColor,
                      fontWeight: FontWeight.bold)),
                  ),
                  StatsInfoSection(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Material(
              color: Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(7),
              shadowColor: baseColor,
              child : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,0),
                    child: Text("Understand Coronavirus", textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 15,
                            color: baseColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  SymptomInfoSection(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Material(
              color: Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(7),
              shadowColor: baseColor,
              child : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,0),
                    child: Text("Myth Busters", textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 15,
                          color: baseColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  MythsInfoSection(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Material(
              color: Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(7),
              shadowColor: baseColor,
              child : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,0),
                    child: Text("CoronaVirus Videos", textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 15,
                          color: baseColor,
                          fontWeight: FontWeight.bold),),
                  ),
                  YoutubeInfoSection(),
                ],
              ),
            ),
          ),
          (_getStats.inIndia) ?
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,8),
            child: Material(
              color: Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(7),
              shadowColor: baseColor,
              child : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top : 15,bottom: 10),
                    child: Text("Government Helpdesk", textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 15,
                          color: baseColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GovHelpDeskSection(),
                ],
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}