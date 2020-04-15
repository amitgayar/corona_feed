import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String appName = "Corona Feed";

//List of URLS for Feed
const List urlForFeed = [
  "https://news.google.com/rss/search?q=covid&hl=en-IN&gl=IN&ceid=IN:en"
];

//Constant URL's
const String countTrackUrlWorld = "https://www.worldometers.info/coronavirus/";
const String countTrackUrlIndia = "https://www.worldometers.info/coronavirus/country/india/";

const String LiveWorldStatsUrl = "https://google.com/covid19-map/?hl=en";
const String whoQnaUrl = "https://www.who.int/news-room/q-a-detail/q-a-coronaviruses";
const String chatUrl = "https://www.google.co.in/";

const String geoLocationUrl = "https://geolocation-db.com/json/";
const String worldDataUrl = "https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search?limit=500";
const String indiaDataUrl = "https://api.covid19india.org/v2/state_district_wise.json";

const String API_KEY = "AIzaSyDcCRTwQn9ElRsDwh1U2OxF2-mPuJ2CKqQ";
const String initialVideoId = "https://www.youtube.com/watch?v=TDDYniiL17A&list=PLGqF2Eq4iV7_vrLoZJiqJdptLlAlEBRRQ&index=2&t=0s";
const String myGovChannelId = 'UCTJpJk8bqQQEqeX58z8eimA';
const List playlist =
    [ "PLGqF2Eq4iV7_vrLoZJiqJdptLlAlEBRRQ", /*Know About Coronavirus*/
      "PLGqF2Eq4iV78hhD6m_hDUV1b0C8_9X-sk", /*PM Narendra Modi on Coronavirus*/
      "PL1a9DHjZmejE-Ep2PAu2OR8HBfLP0BLIk"  /*COVID-19 Management Ministry of Health & Family Welfare*/
    ];

//Feed Filter Keywords.
const String filter1 = "Coronavirus";
const String filter2 = "COVID-19";
const String filter3 = "SARS-CoV-2";
const String filter4 = "Lockdown";
const String filter5 = "quarantine";

//User Authentication Codes
const mobileNumber = 1;
const emailID = 2;
const userName = 3;
const password = 4;
const otp = 5;

//Buttons Codes
const SignUp = 7;
const Login = 8;
const loginWithOtp = 9;
const resendOtp = 10;

//Assets
const String coronaGIF = "assets/coronaVirus.gif";
const String noImageAvailable = "assets/indiaFlag.png";
const List<Map> infoImages = [
  {"text" : "", "img" : "assets/symptoms.png"},
  {"text" : "HOW IT SPREADS", "img" : "assets/howItSpreads.png"},
  {"text" : "PREVENTION", "img" : "assets/prevention.png"},
];
const List<Map> mythItemList = [
  {"image": "assets/mythImg/myth1.png" , "myth" : "Cold weather and snow CANNOT kill the Coronavirus." },
  {"image": "assets/mythImg/myth2.png" , "myth" : "Coronavirus CAN be transmitted in areas with hot and humid weather."},
  {"image": "assets/mythImg/myth3.png" , "myth" : "Coronavirus CANNOT be transmitted through mosquito bites." },
  {"image": "assets/mythImg/myth4.png" , "myth" : "There is NO evidence that coronavirus can be transmitted through animals." },
  {"image": "assets/mythImg/myth5.png" , "myth" : "Taking a Hot bath does NOT prevent coronavirus." },
  {"image": "assets/mythImg/myth6.png" , "myth" : "Hand Dryers are NOT effective in killing the coonavirus."},
  {"image": "assets/mythImg/myth7.png" , "myth" : "Ultraviolet light should NOT be used for sterilization and can cause skin irritation" },
  {"image": "assets/mythImg/myth8.png" , "myth" : "Thermal Scanners can detect only fever but NOT the coronavirus"},
  {"image": "assets/mythImg/myth9.png" , "myth" : "Spraying Alcohols or Chlorine over your body WILL NOT kill the viruses already entered into your body."},
  {"image": "assets/mythImg/myth10.png" , "myth" : "Vaccines against pneumonia, such as pneumococcal vaccine and Haemophilus influenzae type b(Hib) vaccine, DO NOT provideprotection against Coronavirus" },
  {"image": "assets/mythImg/myth11.png" , "myth" : "There is NO evidence that regualarly rinsing the nose with saline has protected people from infection wirh coronavirus." },
  {"image": "assets/mythImg/myth12.png" , "myth" : "Garlic is healthy but there is NO evidence from the current outbreak that eating garlic has protected people from the coronavirus." },
  {"image": "assets/mythImg/myth13.png" , "myth" : "Antibiotics DO NOT work against viruses, antibiotics only work against bacteria." },
  {"image": "assets/mythImg/myth14.png" , "myth" : "To date there is no specific medicine recommended to prevent or treat coronavirus." },
];

const Color baseColor = Color(0xffea70b1);
const Color bgColor = Color.fromRGBO(252, 251, 254,1);


getResponse(url) async{
  http.Client client = http.Client();
  http.Response response = await client.get(url);
  return response.body;
}

//TextField Validator function
String validate(String val,int type) {
  if (val.isEmpty)                           return "Field Can't be Empty";
  else if (val.length < 3 && type == 3)      return "Can't be less than 3";
  else if (val.length > 6 && type == 5)      return "Can't be greater than 6";
  else if (val.length < 8 && type == 4)      return "Can't be less than 8";
  else if (type == 1 && val.length != 10)    return "must be of 10 digits";
  else if ((!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z]+\.[a-z][a-z][a-z]+").hasMatch(val)) && type == 2)
    return "Invalid Email";
  else return null;
}

String fireBaseErrorMessage(String errorMsg){
  if(errorMsg.contains("ERROR_WRONG_PASSWORD")) return "Incorrect Password Entered";
  else if(errorMsg.contains("ERROR_USER_NOT_FOUND")) return "Email ID Not Registered";
  else if(errorMsg.contains("ERROR_NETWORK_REQUEST_FAILED")) return "Internet Connection Error";
  else if(errorMsg.contains("ERROR_EMAIL_ALREADY_IN_USE")) return "Email ID Already Registered";
  else if(errorMsg.contains("Given String is empty or null")) return "Email Id or Password Can't be Empty";
  return "Some Error Occured.Please Try Again";
}


bool checkURL(url){
  final String urlRegex = "^((https?|ftp)://|(www|ftp)\\.)?[a-z0-9-]+(\\.[a-z0-9-]+)+([/?].*)?\$";
  if ((!RegExp(urlRegex).hasMatch(url)))
    return false;
  else
    return true;
}

bool filterData(text){
  if(text.contains(filter1) || text.contains(filter2) || text.contains(filter3) ||
      text.contains(filter4) || text.contains(filter5))
    return true;
  else
    return false;
}

comp(String a, String b) {

  print("Inside comp");

  Map<String, int> monthsMap;

  monthsMap["Jan"] = 1;
  monthsMap["Feb"] = 2;
  monthsMap["Mar"] = 3;
  monthsMap["Apr"] = 4;
  monthsMap["May"] = 5;
  monthsMap["Jun"] = 6;
  monthsMap["Jul"] = 7;
  monthsMap["Aug"] = 8;
  monthsMap["Sep"] = 9;
  monthsMap["Oct"] = 10;
  monthsMap["Nov"] = 11;
  monthsMap["Dec"] = 12;

  // Comparing the years
  String str1 = a.substring(7, 11);
  String str2 = b.substring(7, 11);
  if (str1.compareTo(str2) != 0) {
    print("1");
    if (str1.compareTo(str2) < 0)
      return true;
    return false;
  }

  // Comparing the months
  String monthSubA = a.substring(3, 5);
  String monthSubB = b.substring(3, 5);

  // Taking numeric value of months from monthsMap
  int monthA = monthsMap[monthSubA];
  int monthB = monthsMap[monthSubB];
  if (monthA != monthB) {
    return monthA < monthB;
  }

  // Comparing the days
  String dayA = a.substring(0, 2);
  String dayB = b.substring(0, 2);
  if (dayA.compareTo(dayB) < 0)
    return true;
  return false;
}
