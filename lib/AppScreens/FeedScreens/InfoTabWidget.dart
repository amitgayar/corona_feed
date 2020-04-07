import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/GovHelpDeskSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/MythsInfoSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/SymptomsInfoSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/YoutubeInfoSection.dart';
import 'package:modular_login/AppScreens/InfoSectionScreens/statsInfoSection.dart';
import 'package:modular_login/constants/constants.dart';

class InfoTabWidget extends StatefulWidget {
  @override
  _InfoTabWidgetState createState() => _InfoTabWidgetState();
}

class _InfoTabWidgetState extends State<InfoTabWidget> {
  @override
  Widget build(BuildContext context) {
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
              child : ExpansionTile(
                title: Text("CoronaVirus Statistics", textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 15,
                      color: baseColor,
                      fontWeight: FontWeight.bold),),
                children: <Widget>[StatsInfoSection()],
                initiallyExpanded: true,
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
              child : ExpansionTile(
                title: Text("Understand Coronavirus", textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 15,
                      color: baseColor,
                      fontWeight: FontWeight.bold),),
                children: <Widget>[SymptomInfoSection()],
                initiallyExpanded: true,
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
              child : ExpansionTile(
                title: Text("Myths Busted", textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 15,
                      color: baseColor,
                      fontWeight: FontWeight.bold),),
                children: <Widget>[MythsInfoSection()],
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
              child : ExpansionTile(
                title: Text("Videos", textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 15,
                      color: baseColor,
                      fontWeight: FontWeight.bold),),
                children: <Widget>[
                  YoutubeInfoSection()
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
              child : ExpansionTile(
                title: Text("Government HelpDesk", textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 15,
                      color: baseColor,
                      fontWeight: FontWeight.bold),),
                children: <Widget>[
                  GovHelpDeskSection()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}