class User{

  final String uid;
  String email;
  String mobile;
  String password;
  String otp;

  User({ this.uid });

  setEmail (data) {email = data;}
  setPassword (data) {password = data;}
  setMobile (data) {mobile = data;}
  setOtp (data) {otp = data;}

}