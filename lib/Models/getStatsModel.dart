import 'dart:convert';
import 'package:modular_login/Models/IndiaStatsExtractModel.dart';
import 'package:modular_login/Models/WorldStatsExtractModel.dart';
import 'package:modular_login/constants/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modular_login/constants/constants.dart';


class GetStatistics {

  String countryTotalCases = "";
  String countryDeceasedCases = "" ;
  int stateCases = 0;
  int cityCases =0;
  String stateCasesText = "";
  String cityCasesText = "";
  String countryCode = "";
  String state = "";
  String city = "";
  String flagLink = "https://www.worldometers.info/img/flags/in-flag.gif";
  bool inIndia = true;

  String totalCasesWorld = "";
  String deceasedCasesWorld = "";

  getLocation() async{
    Map locationMap = jsonDecode(await getResponse(geoLocationUrl));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country_code', locationMap['country_code']);
    countryCode = locationMap['country_code'];
    prefs.setString('country_name', locationMap['country_name']);
    prefs.setString('city', locationMap['city']);
    city = locationMap['city'];
    prefs.setString('state', locationMap['state']);
    state = locationMap['state'];

    if(locationMap['country_name'] == "India")
      inIndia = true;
    else
      inIndia = false;
    prefs.setBool('inIndia', inIndia);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("totalCasesWorld",totalCasesWorld );
    prefs.setString("deceasedCasesWorld",deceasedCasesWorld);

    for(int i=0; i<dataRows.length ; i++){
      if(dataRows[i].countryAbbreviation.toUpperCase() == countryCode){
        countryTotalCases = dataRows[i].totalCases;
        countryDeceasedCases = dataRows[i].totalDeaths;
        flagLink = dataRows[i].flag;
      }
    }
    prefs.setString("flagLink", flagLink);
    prefs.setString("countryTotalCases", countryTotalCases);
    prefs.setString("countryDeceasedCases", countryDeceasedCases);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("stateCases", stateCases);
    prefs.setInt("cityCases", cityCases);
  }
}