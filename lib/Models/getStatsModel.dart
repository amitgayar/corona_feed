import 'dart:convert';
import 'package:modular_login/Models/IndiaStatsExtractModel.dart';
import 'package:modular_login/Models/WorldStatsExtractModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modular_login/constants/constants.dart';


class GetStatistics {
  String countryTotalCases = "";
  String countryDeceasedCases = "" ;
  String stateCases = "0";
  String cityCases = "";
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
    print("loc : ${locationMap.toString()}");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    countryCode = locationMap['country_code'];
    prefs.setString('country_code', locationMap['country_code']);
    prefs.setString('country_name', locationMap['country_name']);

    city = locationMap['city'];
    prefs.setString('city', locationMap['city']);

    state = locationMap['state'];
    prefs.setString('state', locationMap['state']);

    if(state == "National Capital Territory of Delhi"){
      state = "Delhi";
      prefs.setString('state', state+"(NCR)");
    }

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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int stateIndex;
    var json;
    IndiaStatsExtractModel _indiaStats;

    await getResponse(indiaDataUrl).then((val) {
      json = jsonDecode(val);
      stateIndex = json.indexWhere((val) => val["state"].toString() == state);
      if(stateIndex!=-1) {
        _indiaStats = IndiaStatsExtractModel.fromJson(json[stateIndex]);

        for(int i=0 ; i<_indiaStats.districtData.length ; i++){
          stateCases = (int.parse(stateCases) + _indiaStats.districtData[i].confirmed).toString();
          if(_indiaStats.districtData[i].district == city){
            cityCases = _indiaStats.districtData[i].confirmed.toString();
          }
        }
        if(city == "Delhi")  cityCases = stateCases;
      }else{
        stateCases = "-";
        cityCases = "-";
      }
      prefs.setString("stateCases", stateCases);
      prefs.setString("cityCases", cityCases);
    });
  }
}