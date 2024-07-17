import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:raydeo_one/graphqlapi/graphql_api.dart';
import '../../utils/constant.dart';

class radioStationScreen extends StatefulWidget {
  const radioStationScreen({super.key});

  @override
  State<radioStationScreen> createState() => _radioStationScreenState();
}

// ignore: camel_case_types
class _radioStationScreenState extends State<radioStationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController locController = TextEditingController();
  RegExp regx = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    urlController.dispose();
    locController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: maincolor),
          title: Text(
            "Submit a Radio Station",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDark == true ? Colors.white : Colors.black,
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: [
                  Text(
                    "To submit a radio station to Radio.ONE, please fill this form.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: isDark == true ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: screensize.height * 0.045,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Station Name',
                            labelStyle: TextStyle(color: maincolor),
                            hintText: 'Station Name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Station name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: screensize.height * 0.04,
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: locController,
                          decoration: InputDecoration(
                            labelText: 'Station Location',
                            labelStyle: TextStyle(color: maincolor),
                            hintText: 'Station Location',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Station Location';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: screensize.height * 0.04,
                        ),
                        TextFormField(
                          controller: urlController,
                          decoration: InputDecoration(
                            labelText: 'Station URL',
                            labelStyle: TextStyle(color: maincolor),
                            hintText: 'Station URL',
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !regx.hasMatch(value)) {
                              return 'Please enter correct URL';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: screensize.height * 0.04,
                        ),
                        SizedBox(
                          height: screensize.height * 0.045,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: maincolor),
                            onPressed: () async {
                              FocusManager.instance.primaryFocus!.unfocus();
                              if (_formKey.currentState!.validate()) {
                                var resp = await GraphqlServices()
                                    .createChannel(nameController.text,
                                        locController.text, urlController.text);
                                print("bcvajvdvavdavj$resp");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: maincolor,
                                        behavior: SnackBarBehavior.floating,
                                        shape: const StadiumBorder(),
                                        duration: const Duration(seconds: 3),
                                        content: const Text(
                                            "Submitted Succesfully")));
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
