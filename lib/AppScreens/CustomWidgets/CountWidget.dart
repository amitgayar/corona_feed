import 'package:flutter/material.dart';
import 'package:modular_login/constants/constants.dart';

class CountWidget extends StatefulWidget {
  @override
  _CountWidgetState createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {

  String totalCasesIndia = "";
  String deceasedCasesIndia = "" ;

  String totalCasesWorld = "";
  String deceasedCasesWorld = "";

  @override
  void initState() {
    super.initState();
    getWorldData();
    getIndiaData();
  }

  getIndiaData() async {
    String response = await getResponse(countTrackUrlIndia);
    String data = response.substring(response.lastIndexOf("<title>"),response.indexOf("</title>"));
//    print("Data = $data");
    totalCasesIndia = data.substring(data.indexOf(":")+1,data.indexOf("Cases"));
    deceasedCasesIndia = data.substring(data.indexOf("and")+3,data.indexOf("Deaths"));
//    print("Data = $totalCasesIndia");
//    print("Data = $deceasedCasesIndia");
  }

  getWorldData() async {
    String response = await getResponse(countTrackUrlWorld);
    String data = response.substring(response.lastIndexOf("<title>"),response.indexOf("</title>"));
//    print("Data = $data");
    totalCasesWorld = data.substring(data.indexOf(":")+1,data.indexOf("Cases"));
    deceasedCasesWorld = data.substring(data.indexOf("and")+3,data.indexOf("Deaths"));
//    print("Data = $totalCasesWorld");
//    print("Data = $deceasedCasesWorld");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,20,20,20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/worldIcon.png",width: 40,height: 40,color: Colors.blue[900],),
                      SizedBox(height: 8,),
                      Text(
                        "WORLD",
                        style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Total Cases",
                          style: new TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      (totalCasesWorld.isNotEmpty) ?
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          totalCasesWorld,
                          style: new TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ) :
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.10,
                          child: LinearProgressIndicator(backgroundColor: baseColor,)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                            "Deceased",
                          style: new TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      (deceasedCasesWorld.isNotEmpty) ?
                      Text(
                        deceasedCasesWorld,
                        style: new TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20,
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
              ),
              Divider(
                thickness: 2,
                height : 35,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/indiaFlag.png",width: 40,height: 40),
                      SizedBox(height: 8,),
                      Text(
                        "INDIA",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Total Cases",
                          style: new TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      (totalCasesIndia.isNotEmpty) ?
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          totalCasesIndia,
                          style: new TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ) :
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: LinearProgressIndicator(backgroundColor: baseColor)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Deceased",
                          style: new TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      (deceasedCasesWorld.isNotEmpty) ?
                      Text(
                        deceasedCasesIndia,
                        style: new TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20,
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Source : Worldometers.info/coronavirus",
                  style: new TextStyle(
                      color: Colors.grey[500],
                      fontSize: 10,
                      fontWeight: FontWeight.w300
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}