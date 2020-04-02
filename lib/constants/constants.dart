import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//List of URLS for Feed
const List urlForFeed = [
  "https://www.sciencedaily.com/rss/top/health.xml",
  "https://www.sciencedaily.com/rss/top/environment.xml",
  "https://www.sciencedaily.com/rss/health_medicine/viruses.xml",
  "https://indianexpress.com/section/lifestyle/health/feed/",
  "https://indianexpress.com/section/opinion/feed/",
  "https://www.cnbc.com/id/10000108/device/rss/rss.html",
  "https://timesofindia.indiatimes.com/rssfeedstopstories.cms",
  "https://www.businesstoday.in/rss/rssstory.jsp?sid=109",
  "https://www.thehindu.com/news/national/feeder/default.rss",
  "https://www.thehindu.com/news/cities/Delhi/feeder/default.rss",
  "https://www.thehindu.com/news/international/feeder/default.rss",
  "https://www.thehindu.com/business/feeder/default.rss",
  "https://www.thehindu.com/news/feeder/default.rss",
  "https://www.businesstoday.in/rss/rssstory.jsp?sid=105",
  "https://www.businesstoday.in/rss/rssstory.jsp?sid=111",
];

const List Sources = [
  "sciencedaily",
  "indianexpress",
  "cnbc",
  "timesofindia",
  "thehindu",
  "businesstoday"
];

const List sourcesFormatted = [
  "Science Daily",
  "The Indian Express",
  "CNBC",
  "Times of India",
  "The Hindu",
  "Business Today"
];

const String countTrackUrlWorld = "https://www.worldometers.info/coronavirus/";
const String countTrackUrlIndia = "https://www.worldometers.info/coronavirus/country/india/";
const String countTrackUrlIndia2 = "https://www.covid19india.org/";


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
const String noImageAvailable = "/assets/no_image_availaible_.jpg";
const List coronaImgList = ["assets/img1.png" , "assets/img3.jpg" , "assets/defaultThumbnail.png"];


const Color baseColor = Color(0xffea70b1);


getResponse(url) async{
  http.Client client = http.Client();
  http.Response response = await client.get(url);
//  print("Response length : ${response.body.length}");
  return response.body;
}

//TextField Validator function
String validate(String val,int type) {
  if (val.isEmpty)                             return "Can't be Empty";
  else if (val.length < 3)                          return "Can't be less than 3";
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

const String defaultImageURL = "https://www.pinclipart.com/picdir/big/355-3553881_stockvader-predicted-adig-user-profile-icon-png-clipart.png";

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
