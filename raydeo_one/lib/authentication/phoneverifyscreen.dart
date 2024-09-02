import '../utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'firebaseauth.dart';

class PhoneVerifyScreen extends StatefulWidget {
  final cc;
  final phoneNumber;
  final verificationID;

  const PhoneVerifyScreen(
    this.cc,
    this.phoneNumber,
    this.verificationID,
  );

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  String enteredOTP = '';
  bool verificationStarted = false;
  bool isloading1 = false;
  final TextEditingController phoneNumnerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? otpSent;

  bool _isOTPSent = false;
  bool _isPhoneNumberValid = false;
  bool ontapped = true;
  String phoneNumber = "";
  var countryCode;

  String? _currentAddress;
  String? currentAddress;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: isDark == true ? Colors.grey.shade900 : Colors.white,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: BackButton(color: maincolor),
          backgroundColor: isDark == true ? Colors.grey.shade900 : Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height * 0.9,
            color: isDark == true ? Colors.grey.shade900 : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(
                //   height: screenSize.height * 0.05,
                // ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 180,
                          height: 180,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/Raydeo.ONESqLogo.jpg"))),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Radio.ONE ',
                                style:
                                    TextStyle(fontSize: 30, color: maincolor),
                                children: const <TextSpan>[],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: screenSize.height * 0.03,
                ),

                Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Enter the OTP sent',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${widget.cc}${widget.phoneNumber}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                PinCodeTextField(
                  backgroundColor: Theme.of(context).backgroundColor,
                  autoFocus: true,
                  pinTheme: PinTheme(
                    selectedFillColor:
                        isDark == true ? Colors.white : Colors.grey.shade900,
                    activeColor: Colors.green,
                    fieldHeight: 25,
                    fieldWidth: 34,
                    inactiveColor: Theme.of(context).primaryColorLight,
                    selectedColor:
                        isDark == true ? Colors.white : Colors.grey.shade900,
                  ),
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                    enteredOTP = value;
                  },
                  onCompleted: (value) {
                    verifyotp();
                  },
                ),

                SizedBox(
                  height: screenSize.height * 0.07,
                ),

                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                (verificationStarted == true)
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Authenticating...",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyotp() async {
    var res = await FirebaseConfiguration().verifyOTP(
      widget.cc,
      widget.phoneNumber,
      enteredOTP,
      widget.verificationID,
      context,
    );
    if (res == "SUCESS") {
      setState(() {
        verificationStarted = false;
      });
    }
  }
}
