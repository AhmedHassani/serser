import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:senser/home/Home.dart';


class OTPUI extends StatefulWidget {
  String number;
  OTPUI(this.number);
  @override
  _OTPUIState createState() => _OTPUIState();
}

class _OTPUIState extends State<OTPUI> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(32, 36, 52,1),
      ),
      body:OtpScreen.withGradientBackground(
        topColor: Color.fromRGBO(32, 36, 52,1),
        bottomColor: Color.fromRGBO(30, 40, 60,1),
        otpLength: 6,
        validateOtp: validateOtp,
        routeCallback: moveToNextScreen,
        themeColor: Colors.white,
        titleColor: Colors.white,
        title: "Phone Number Verification",
        subTitle: "Enter the code sent to \n +964${widget.number}",
      ),
    );
  }
  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    print(widget.number);
    if (otp == "123456") {
      return null;
    } else {
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Home()));
  }

  signIn(String smsOTP) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      var  user = await _auth.signInWithCredential(credential);
      var currentUser = await _auth.currentUser;
      assert(user.user.uid == currentUser.uid);
      //Navigator.pushReplacementNamed(context, '/homeScreen');
    } catch (e) {

    }
  }
}









