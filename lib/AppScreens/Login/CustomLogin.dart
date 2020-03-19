
class CustomLogin {

  final mobileNumber = 1;
  final emailID = 2;
  final userName = 3;

  final password = 4;
  final otp = 5;

  int userType , passwordType;
  int minLengthUserid , maxLengthUserid;
  int minLengthPasswd , maxLengthPasswd;

  CustomLogin( int userType , int passwordType){
    this.userType = userType;
    this.passwordType = passwordType;

    if(userType == 1){
      minLengthUserid = 10;   maxLengthUserid = 10;
    }else{
      minLengthUserid = 3;   maxLengthUserid = 15;
    }

    if(passwordType == 5){
      minLengthPasswd = 4;   maxLengthPasswd = 6;
    }
  }

  CustomLogin.globe( int UserType,int passwordType,int minLengthUserid,int maxLengthUserid,int minLengthPasswd ,int maxLengthPasswd){
    this.userType = UserType;
    this.passwordType = passwordType;
    this.minLengthUserid = minLengthUserid;
    this.maxLengthUserid = maxLengthUserid;
    this.minLengthPasswd = minLengthPasswd;
    this.maxLengthPasswd = maxLengthPasswd;
  }

  bool userIdValidation(int userType , String Data){

  }

  bool passwordValidation(int userType , String data){

  }

  String getTextAndLabel(int userType){
    switch(userType){
      case 1 : return "Mobile Number";
      break;
      case 2 : return "Email";
      break;
      case 3 : return "User Name";
      break;
      case 4 : return "Password";
      break;
      case 5 : return "OTP";
      break;
    }
  }

  String getKeyBoardType(int userType){
    switch(userType){
      case 1 : return "phone";
      break;
      case 2 : return "emailAddress";
      break;
      case 3 : return "text";
      break;
      case 4 : return "Password";
      break;
      case 5 : return "OTP";
      break;
    }
  }

  bool otpTimerResend(int val){

  }
}
