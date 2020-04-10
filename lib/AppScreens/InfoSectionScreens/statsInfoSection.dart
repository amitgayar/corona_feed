import 'package:flutter/material.dart';
import 'package:modular_login/AppScreens/FeedScreens/WebView.dart';
import 'package:modular_login/Models/getStatsModel.dart';
import 'package:modular_login/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsInfoSection extends StatefulWidget {

  @override
  _StatsInfoSectionState createState() => _StatsInfoSectionState();
}

class _StatsInfoSectionState extends State<StatsInfoSection> {

  String state;
  String stateCasesText;
  String cityCasesText ;
  String city;
  String flagLink = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/International_Flag_of_Planet_Earth.svg/800px-International_Flag_of_Planet_Earth.svg.png";
  String countryTotalCases="";
  String countryDeceasedCases="";
  String stateCases;
  String cityCases;
  String totalCasesWorld;
  String deceasedCasesWorld ;
  bool inIndia = false;

  getDataFromSharedPref() async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    state = pref.get("state");
    stateCasesText = pref.get("stateCasesText");
    cityCasesText = pref.get("cityCasesText ");
    city = pref.get("city");
    flagLink = pref.get("flagLink");
    countryTotalCases = pref.get("countryTotalCases");
    countryDeceasedCases = pref.get("countryDeceasedCases");
    stateCases = pref.get("stateCases").toString();
    cityCases = pref.get("cityCases");
    totalCasesWorld = pref.get("totalCasesWorld");
    deceasedCasesWorld  = pref.get("deceasedCasesWorld");
    inIndia = pref.get("inIndia");
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getDataFromSharedPref();

    GetStatistics _getStats = new GetStatistics();
    _getStats.getLocation().then((val) {
      _getStats.getWorldCountryData();
      _getStats.getIndiaData();
      state = _getStats.state;
      stateCasesText = _getStats.stateCasesText;
      cityCasesText = _getStats.cityCasesText ;
      city = _getStats.city;
      flagLink = _getStats.flagLink;
      countryTotalCases = _getStats.countryTotalCases;
      countryDeceasedCases = _getStats.countryDeceasedCases;
      stateCases = _getStats.stateCases.toString();
      cityCases = _getStats.cityCases;
      totalCasesWorld = _getStats.totalCasesWorld;
      deceasedCasesWorld  = _getStats.deceasedCasesWorld;
      inIndia = _getStats.inIndia;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          countryWidget(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(),
          ),
          worldWidget()
        ],
      ),
    );
  }

  countryWidget()  {
    if(state!=null) stateCasesText = state + " Cases";
    if(city!=null) cityCasesText = city + " Cases";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () => openStatsPage(),
                child: Image.network(flagLink,width: MediaQuery.of(context).size.width * 0.10)
            )
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: Column(
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
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: Column(
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
                      ),
                    ),
                  ),
                )
              ],
            ),
            (inIndia) ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: Column(
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
                          (stateCases!=null) ? Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              stateCases ,
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
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: Column(
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
                          (cityCases!=null) ? Text(
                            cityCases ,
                            style: new TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500
                            ),
                          )
                              : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.10,
                              child: LinearProgressIndicator(backgroundColor: baseColor)
                          ),
                        ],
                      ),
                    ),
                  ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () => openStatsPage(),
                child: Image.asset("assets/worldIcon.png", width: MediaQuery.of(context).size.width *0.10)
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: Column(
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
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: Column(
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
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  openStatsPage() {
    UrlData _urlData = new UrlData(url: LiveWorldStatsUrl, title: "Live World Stats");
    Navigator.pushNamed(context, '/customWebView', arguments: _urlData);
  }

}