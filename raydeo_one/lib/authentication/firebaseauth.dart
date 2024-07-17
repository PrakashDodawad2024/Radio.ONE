import 'package:firebase_auth/firebase_auth.dart';
import '../utils/constant.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raydeo_one/application/profilepages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'phoneverifyscreen.dart';

class FirebaseConfiguration {
  FirebaseAuth auth = FirebaseAuth.instance;
  List informstion = [];

  Future phoneNumberVerification(countryCode, phoneNumber, context) async {
    print("countrycode$countryCode");
    print("phoneNumber$phoneNumber");
    try {
      await auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 5),
          phoneNumber: '$countryCode$phoneNumber',
          verificationCompleted: (PhoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException exception) async {
            print("wdavcz");
            isloading.value = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                showCloseIcon: true,
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
                content: Text(
                  "${exception.message}",
                )));
            // Generic().showLoadingIndicator(context);
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("${exception.message}")));
          },
          codeSent: (String VerificationID, int? resendToken) async {
            otpsent.value = false;

            isloading.value = false;

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PhoneVerifyScreen(
                    countryCode,
                    phoneNumber,
                    VerificationID,
                  ),
                ));
          },
          codeAutoRetrievalTimeout: (String VerificationID) {});
      return 'SUCCESS';
    } catch (error) {
      print(error);
      return 'ERROR';
    }
  }

  verifyOTP(
    countryCode,
    phoneNumber,
    otp,
    verificationid,
    context,
  ) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationid, smsCode: otp);
    auth.signInWithCredential(authCredential).then(
      (result) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        SharedPreferences prefs = await SharedPreferences.getInstance();

        sharedPreferences.setString('userCountryCode', countryCode);
        print('userCountryCode:$countryCode');
        sharedPreferences.setString('userNumber', phoneNumber);
        print('userNumber:$phoneNumber');
        sharedPreferences.setBool('Signedin', true);
        prefs.setBool('isFirstTime', false);
        print("siiignedIn:${prefs.getBool('isFirstTime')}");

        print("signedIn:${sharedPreferences.getBool('Signedin')}");

        // await grapqlapiservice().getConusmer();
        accountdetails!.put("MobNoVerified", true);
        accountdetails!.put("mobileNumber", "$countryCode$phoneNumber");

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const Profile())));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: maincolor,
            shape: const StadiumBorder(),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            content: const Text(
              "Mobile Number verified Successfully.....!",
            ),
          ),
        );
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          shape: StadiumBorder(),
          showCloseIcon: true,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Text(
            "Please enter the correct OTP...!",
          )));
    });
    return "SUCESS";
  }
}
