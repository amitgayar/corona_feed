//List of URLS for Feed
const List urlForFeed = [
  "https://www.sciencedaily.com/rss/health_medicine/viruses.xml",
  "https://indianexpress.com/section/lifestyle/health/feed/",
  "https://www.cnbc.com/id/10000108/device/rss/rss.html",
  "https://indianexpress.com/section/opinion/feed/",
  "https://www.sciencedaily.com/rss/top/environment.xml",
];

const List Sources = [
  "sciencedaily",
  "indianexpress",
  "cnbc",
];

const List sourcesFormatted = [
  "Science Daily",
  "The Indian Express",
  "CNBC",
];

//Feed Filter Keywords
const String filter1 = "Coronavirus";
const String filter2 = "COVID-19";
const String filter3 = "SARS-CoV-2";

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
const String CoronaGIF = "assets/coronaVirus.gif";

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

String firebaseErrorMessage(String errorMsg){
  if(errorMsg.contains("ERROR_WRONG_PASSWORD")) return "Incorrect Password Entered";
  else if(errorMsg.contains("ERROR_USER_NOT_FOUND")) return "Email ID Not Registered";
  else if(errorMsg.contains("ERROR_NETWORK_REQUEST_FAILED")) return "Internet Connection Error";
  else if(errorMsg.contains("ERROR_EMAIL_ALREADY_IN_USE")) return "Email ID Already Registered";
  else return "Some Error Occured.Please Try Again";
}