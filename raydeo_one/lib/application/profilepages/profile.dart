import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raydeo_one/application/landingpages/homepage.dart';
import 'package:raydeo_one/application/profilepages/radio_station.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constant.dart';
import 'mobilenumber.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final text = TextEditingController();
  RxBool validate = false.obs;
  bool verified = accountdetails!.get(
        "MobNoVerified",
      ) ??
      false;
  String mobileNumber = accountdetails!.get(
        "mobileNumber",
      ) ??
      "Mobile Number";
  String username = accountdetails!.get(
        "username",
      ) ??
      "Your Name";

  bottommodalsheet() async {
    if (!mounted) return false;
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        final screensize = MediaQuery.of(context).size;
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 180,
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 24),
                          child: Text('Enter Your Name',
                              style: Theme.of(context).textTheme.bodyLarge
                              // style: TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.black),
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screensize.width * .028,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 60),
                      padding: const EdgeInsets.all(1),
                      width: double.infinity,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          autofocus: true,
                          maxLength: 25,
                          // controller: text,
                          initialValue: username == "Your Name" ? "" : username,
                          onChanged: (value) {
                            changename = value;
                            print("usernamedqdada1$value$username");
                          },
                          decoration: const InputDecoration(
                            counterText: "",
                            isDense: true,
                          ),
                          validator: (name) {
                            if (name!.isEmpty || name == "") {
                              return "Required Name";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screensize.width * .015,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: maincolor),
                            )),
                      ),
                      TextButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus!.unfocus();
                            if (_formKey.currentState!.validate()) {
                              if (changename.isEmpty) {
                                username == changename
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        shape: StadiumBorder(),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.red,
                                        content:
                                            Text('Name shouldn\'t be empty '),
                                      ))
                                    : Navigator.of(context).pop();
                              } else {
                                username = changename;
                                accountdetails!.put("username", username);
                                username != changename
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        duration: const Duration(seconds: 3),
                                        shape: const StadiumBorder(),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: maincolor,
                                        content: const Text(
                                            'Profile Updated Succesfully'),
                                      ))
                                    : null;
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Text('Ok',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: maincolor,
                              ))),
                    ])
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: maincolor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Radio.ONE',
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: screensize.height * 0.075,
                      child: ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          size: 25,
                        ),
                        title: Text(
                          '$username',
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            bottommodalsheet();
                          },
                          child: Text(
                            "EDIT",
                            style: TextStyle(
                                color: maincolor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: screensize.height * 0.075,
                      child: ListTile(
                        leading: const Icon(
                          Icons.phone_android,
                          size: 25,
                        ),
                        title: Text(
                          '$mobileNumber',
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: verified == true
                            ? Text(
                                "Verified",
                                style: TextStyle(
                                    color: maincolor,
                                    fontWeight: FontWeight.bold),
                              )
                            : TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const MobileNumberVerificationScreen()));
                                },
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                      color: maincolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          await launchUrl(
                              Uri.parse(
                                  "http://theradio.one/privacypolicy.html"),
                              mode: LaunchMode.externalApplication);
                        } catch (e) {
                          print('url launcher error:${e}');
                        }
                      },
                      child: SizedBox(
                        height: screensize.height * 0.075,
                        child: ListTile(
                          leading: const Icon(
                            Icons.privacy_tip_rounded,
                          ),
                          title: const Text(
                            "Privacy",
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: maincolor,
                              )),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const radioStationScreen()));
                      },
                      child: SizedBox(
                        height: screensize.height * 0.075,
                        child: ListTile(
                          leading: const Icon(
                            Icons.radio,
                          ),
                          title: const Text(
                            "Request to add a station",
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: maincolor,
                              )),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screensize.width * .22,
              ),
              const Spacer(),
              const Center(
                child: Text(
                  "Radio.ONE - Version: 1.0.1",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: screensize.width * .035,
              ),
            ],
          ),
        ));
  }
}
