import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../authentication/firebaseauth.dart';
import '../../utils/constant.dart';

class MobileNumberVerificationScreen extends StatefulWidget {
  const MobileNumberVerificationScreen({super.key});

  @override
  _MobileNumberVerificationScreenState createState() =>
      _MobileNumberVerificationScreenState();
}

class _MobileNumberVerificationScreenState
    extends State<MobileNumberVerificationScreen> {
  final TextEditingController phoneNumnerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? otpSent;
  bool ontapped = true;
  String phoneNumber = "";
  var countryCode;
  @override
  void dispose() {
    phoneNumnerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: isDark == true ? Colors.grey.shade900 : Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor:
                isDark == true ? Colors.grey.shade900 : Colors.white,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: isDark == true ? Colors.white : Colors.black,
                )),
            title: Text(
              'Mobile Number Verification',
              style: TextStyle(
                color: isDark == true ? Colors.white : Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: isDark == true ? Colors.grey.shade900 : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: screensize.height * 0.03,
                    ),
                    const Text(
                      'Please enter your mobile number. verification code will be sent to your number.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screensize.height * 0.03,
                    ),
                    Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: IntlPhoneField(
                        dropdownIcon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: isDark == true ? Colors.white : Colors.black,
                        ),
                        flagsButtonMargin: const EdgeInsets.all(5),
                        dropdownDecoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey.shade300),
                            color: isDark == true ? Colors.black : Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30)),
                        autovalidateMode: AutovalidateMode.disabled,
                        dropdownTextStyle: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 14),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: maincolor),
                            ),
                            filled: true,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: maincolor),
                            labelStyle: TextStyle(color: maincolor),
                            labelText: "Phone Number"),
                        controller: phoneNumnerController,
                        initialCountryCode: "IN",
                        autofocus: false,
                        onChanged: (phone) {
                          countryCode = phone.countryCode;
                        },
                        onTap: () {
                          setState(() {
                            ontapped = false;
                          });
                          // _formKey.currentState!.reset();
                        },
                        validator: (number) {
                          if (ontapped = true) {
                            if (number == null) {
                              return "Required Number";
                            } else {
                              return null;
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: screensize.height * 0.04,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: maincolor),
                          child: isloading.value == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sending OTP...   ',
                                      style: TextStyle(
                                        color: isDark == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    CircularProgressIndicator(
                                      color: isDark == true
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                )
                              : Text(
                                  'Send OTP',
                                  style: TextStyle(
                                    color: isDark == true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseConfiguration().phoneNumberVerification(
                                  countryCode,
                                  phoneNumnerController.text,
                                  context);
                              setState(() {});
                              isloading.value = true;
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
