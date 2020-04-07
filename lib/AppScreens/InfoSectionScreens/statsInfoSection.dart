import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modular_login/Models/IndiaStatsExtractModel.dart';
import 'package:modular_login/Models/WorldStatsExtractModel.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsInfoSection extends StatefulWidget {
  @override
  _StatsInfoSectionState createState() => _StatsInfoSectionState();
}

class _StatsInfoSectionState extends State<StatsInfoSection> {

  bool inIndia = false;

  String countryTotalCases = "";
  String countryDeceasedCases = "" ;
  int stateCases = 0;
  int cityCases =0;
  String stateCasesText = "";
  String cityCasesText = "";
  String countryCode = "";
  String state = "";
  String city = "";
  String flagLink = "";

  String totalCasesWorld = "";
  String deceasedCasesWorld = "";

  @override
  void initState() {
    super.initState();
    getLocation();
    getWorldCountryData();
    getIndiaData();
  }

  getWorldCountryData() async {
    var json = jsonDecode(await getResponse(worldDataUrl));
    WorldStatsExtractModel _worldStats = WorldStatsExtractModel.fromJson(json);
    List<Rows> dataRows = _worldStats.data.rows ;

    for(int i=0; i<dataRows.length ; i++){
      if(dataRows[i].countryAbbreviation.isEmpty){
        totalCasesWorld= dataRows[i].totalCases;
        deceasedCasesWorld = dataRows[i].totalDeaths;
        break;
      }
    }

    for(int i=0; i<dataRows.length ; i++){
      if(dataRows[i].countryAbbreviation.toUpperCase() == countryCode){
        countryTotalCases = dataRows[i].totalCases;
        countryDeceasedCases = dataRows[i].totalDeaths;
        flagLink = dataRows[i].flag;
      }
    }
  }

  getIndiaData() async {
    var json = jsonDecode(await getResponse(indiaDataUrl));
    IndiaStatsExtractModel _indiaStats = IndiaStatsExtractModel.fromJson(json);
    List<RawData> dataRows = _indiaStats.rawData;

    for(int i=0; i<dataRows.length ; i++){
      if(dataRows[i].detectedstate == state)
        stateCases = stateCases + 1;
      if(dataRows[i].detectedcity == city)
        cityCases = cityCases + 1;
    }
    setState(() {});
  }

  getLocation() async{
    Map locationMap = jsonDecode(await getResponse(geoLocationUrl));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country_code', locationMap['country_code']);
    prefs.setString('country_name', locationMap['country_name']);
    countryCode = locationMap['country_code'];
    prefs.setString('city', locationMap['city']);
    city = locationMap['city'];
    prefs.setString('state', locationMap['state']);
    state = locationMap['state'];

    if(locationMap['country_name'] == "India")
      inIndia = true;
    else
      inIndia = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          countryWidget(inIndia),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(),
          ),
          worldWidget()
        ],
      ),
    );
  }

  countryWidget(isIndia)  {
    if(state == "National Capital Territory of Delhi") state = "New Delhi";
    stateCasesText = state + " Cases";
    cityCasesText = city + " Cases";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl: flagLink,
              width: MediaQuery.of(context).size.width * 0.15,
              alignment: Alignment.center,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Total Cases",
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    (countryTotalCases.isNotEmpty) ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        countryTotalCases,
                        style: new TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ) : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: LinearProgressIndicator(backgroundColor: baseColor)),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.10,),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Total Deceased",
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    (countryDeceasedCases.isNotEmpty) ?
                    Text(
                      countryDeceasedCases,
                      style: new TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500
                      ),
                    ) :
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: LinearProgressIndicator(backgroundColor: baseColor)
                    ),
                  ],
                )
              ],
            ),
            (isIndia) ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        stateCasesText,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    (stateCases!=0) ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        stateCases.toString(),
                        style: new TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ) : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: LinearProgressIndicator(backgroundColor: baseColor)),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.10,),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        cityCasesText,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    (cityCases!=0) ? Text(
                      cityCases.toString(),
                      style: new TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500
                      ),
                    ) : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: LinearProgressIndicator(backgroundColor: baseColor)
                    ),
                  ],
                )
              ],
            ) : Container()
          ],
        ),
       ],
    );
  }

  worldWidget()  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.asset("assets/worldIcon.png", width: MediaQuery.of(context).size.width *0.15),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Total Cases",
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    (countryTotalCases.isNotEmpty) ?
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        totalCasesWorld,
                        style: new TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ) :
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: LinearProgressIndicator(backgroundColor: baseColor)),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.10,),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Total Deceased",
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    (countryDeceasedCases.isNotEmpty) ?
                    Text(
                      deceasedCasesWorld,
                      style: new TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500
                      ),
                    ) :
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: LinearProgressIndicator(backgroundColor: baseColor)
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

}