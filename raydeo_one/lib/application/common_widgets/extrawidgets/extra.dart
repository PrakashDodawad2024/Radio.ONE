// _initURIHandler();
//     _incomingLinkHandler();
// 
// 
// 
// Future<void> _initURIHandler() async {
//     if (!_initialURILinkHandled) {
//       _initialURILinkHandled = true;
//       // Fluttertoast.showToast(
//       //     msg: "Invoked _initURIHandler",
//       //     toastLength: Toast.LENGTH_SHORT,
//       //     gravity: ToastGravity.BOTTOM,
//       //     timeInSecForIosWeb: 1,
//       //     backgroundColor: Colors.green,
//       //     textColor: Colors.white);
//       try {
//         final initialURI = await getInitialUri();
//         // Use the initialURI and warn the user if it is not correct,
//         // but keep in mind it could be `null`.
//         if (initialURI != null) {
//           debugPrint("Initial URI received $initialURI");
//           if (!mounted) {
//             return;
//           }
//           setState(() {});
//         } else {
//           debugPrint("Null Initial URI received");
//         }
//       } on PlatformException {
//         // Platform messages may fail, so we use a try/catch PlatformException.
//         // Handle exception by warning the user their action did not succeed
//         debugPrint("Failed to receive initial uri");
//       } on FormatException catch (err) {
//         if (!mounted) {
//           return;
//         }
//         debugPrint('Malformed Initial URI received');
//       }
//     }
//   }

//   /// Handle incoming links - the ones that the app will receive from the OS
//   /// while already started.
//   void _incomingLinkHandler() {
//     if (!kIsWeb) {
//       // It will handle app links while the app is already started - be it in
//       // the foreground or in the background.
//       _streamSubscription = uriLinkStream.listen((Uri? uri) {
//         if (!mounted) {
//           return;
//         }
//         debugPrint('Received URI: $uri');
//         setState(() {});
//       }, onError: (Object err) {
//         if (!mounted) {
//           return;
//         }
//         debugPrint('Error occurred: $err');
//         setState(() {
//           if (err is FormatException) {
//           } else {}
//         });
//       });
//     }
//   }
// 
// 
// 
// 
// 
// Text(
                      //   "$nameOfChannel",
                      //   textAlign:
                      //       TextAlign.center,
                      //   style: const TextStyle(
                      //       fontSize: 25,
                      //       fontWeight:
                      //           FontWeight.bold,
                      //       color: Colors.white),
                      // ),
                      // Row(
                      //   mainAxisAlignment:
                      //       MainAxisAlignment
                      //           .spaceAround,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         // _dialogBuilder(context);
                      //         print("tapped");
                      //         tapped.value = true;
                      //       },
                      //       child: Column(
                      //         children: const [
                      //           Icon(
                      //             Icons
                      //                 .chat_sharp,
                      //             size: 35,
                      //             color: Colors
                      //                 .white,
                      //           ),
                      //           Text(
                      //             "Live Chat",
                      //             style: TextStyle(
                      //                 fontSize:
                      //                     18,
                      //                 fontWeight:
                      //                     FontWeight
                      //                         .bold,
                      //                 color: Colors
                      //                     .white),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {},
                      //       child: Column(
                      //         children: const [
                      //           Icon(
                      //             Icons
                      //                 .keyboard_voice_rounded,
                      //             size: 35,
                      //             color: Colors
                      //                 .white,
                      //           ),
                      //           Text(
                      //             "Detect Audio",
                      //             style: TextStyle(
                      //                 fontSize:
                      //                     18,
                      //                 fontWeight:
                      //                     FontWeight
                      //                         .bold,
                      //                 color: Colors
                      //                     .white),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //
                      ///
                      //////
                      //////
                      /////
                      ///
                      ///// int currentindx = 0;
// int changeindex = 0;
// RxBool openmini = false.obs;
// bool loadingdata = true;
// RxString currentPlaying = "".obs;
// RxInt subcount = 1.obs;
// RxInt curindex = 0.obs;
// int nextindex = 0;
// RxBool playing = false.obs;
// RxBool empty = false.obs;
// RxBool otpsent = false.obs;
// RxBool isloading = false.obs;
// RxBool homepageloader = true.obs;
// RxBool loader = false.obs;
// RxBool miniplay = false.obs;
// RxBool cancel = false.obs;
// RxBool tapped = false.obs;
// RxBool onplay = false.obs;
// RxBool onpause = false.obs;
// RxBool tapemail = false.obs;
// RxBool shownowplaying = false.obs;
// RxBool tapmob = false.obs;
// RxBool opennew = false.obs;
// RxBool favpage = false.obs;
// RxBool nameuser = false.obs;
// RxBool copytext = false.obs;
// bool verified = accountdetails!.get(
//       "MobNoVerified",
//     ) ??
//     false;
// bool addFavourite = false;
// List alldata = [];
// List favlist = [];
// List displayfavlist = [];
// String username = accountdetails!.get(
//       "username",
//     ) ??
//     "Your Name";
// String mobileNumber = accountdetails!.get(
//       "mobileNumber",
//     ) ??
//     "Mobile Number";
// RxList stationdata = [].obs;
// List categories = [];
// String changename = "";
// RxList categorylist = [
//   "Newly Added",
//   "Favourites",
// ].obs;
// RxList titlelist = [].obs;
// RxList viewmorelist = [].obs;
// List urls = [];
// Color bgColor = Colors.purple;
// Color maincolor = const Color.fromARGB(255, 152, 188, 145);
// bool? isFirsttime;
// bool? isRegistered;
// bool Firsttimee = true;
// Box? channel;
// Box? clientdetailBox;
// Box? allmessages;
// Box? accountdetails;
// Box? statiomessages;
// Box? favouritelist;
// String selected = "";
// RxString nameOfChannel = ''.obs;
// RxString descOfChannel = ''.obs;
// RxString urlOfChannel = ''.obs;
// RxString imgurlOfChannel = ''.obs;
// RxString idOfChannel = ''.obs;
// RxString catgOfChannel = ''.obs;
// RxString catgChannel = 'Newly Added'.obs;
// bool isDataConnected = true;
// bool _initialURILinkHandled = false;
// bool viewmore = false;
// bool isDark =
//     SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
// double volumeListenerValue = 0;
// double getVolume = 0;
// double setVolumeValue = 0;
///
///
///
///
///// String email = Uri.encodeComponent("riyad@mobil80.com");
                        // String subject = Uri.encodeComponent("");
                        // String body = Uri.encodeComponent("");
                        // print(subject); //output: Hello%20Flutter
                        // Uri mail =
                        //     Uri.parse("mailto:$email?subject=$subject&body=$body");
                        // if (await launchUrl(mail)) {
                        //   //email app opened
                        // } else {
                        //   //email app is not opened
                        // }
                        // /
                        ///
                        /////
                        ///
//
/////////////////////////Sorting a List of Objects by Date://////////////////////////////
//
// class User {
//   final String name;
//   final String email;
//   final DateTime joinDate;

//   User({required this.name, required this.email, required this.joinDate});

//   @override
//   String toString() {
//     return 'User{name: $name, email: $email, joinDate: $joinDate}';
//   }
// }

// void main() {
//   // list of users
//   List<User> users = [
//     User(
//         name: 'Rahul',
//         email: 'raul@gmail.com',
//         joinDate: DateTime(2022, 10, 3)),
//     User(
//         name: 'John',
//         email: 'john@gmail.com',
//         joinDate: DateTime(2019, 5, 19)),
//     User(
//         name: 'Sam',
//         email: 'sam@gmail.com',
//         joinDate: DateTime(2021, 5, 12)),
    
//   ];

//   // sort by joinDate: ascending
//   final sortedUsersAsc = users.map((user) => user).toList()
//     ..sort((a, b) => a.joinDate.compareTo(b.joinDate));

//   // sort by joinDate: descending
//   final sortedUsersDesc = users.map((user) => user).toList()
//     ..sort((a, b) => b.joinDate.compareTo(a.joinDate));

//   print('Sorted by joinDate: ascending');
//   sortedUsersAsc.forEach((user) => print(user.toString()));

//   print('Sorted by joinDate: descending');
//   sortedUsersDesc.forEach((user) => print(user.toString()));
// }
///
///
///////////////////////////Sorting a List of Maps by Date:///////////////////////////////////
///void main() {
//   final List<Map<String, dynamic>> users = [
//     {
//       "name": "Rahul",
//       "email": "raul@gmail.com",
//       "joinDate": "2022-10-03",
//     },
//     {
//       "name": "John",
//       "email": "john@gmail.com",
//       "joinDate": "2019-05-19",
//     },
//     {
//       "name": "Sam",
//       "email": "sam@gmail.com",
//       "joinDate": "2021-05-12",
//     },
//     {
//       "name": "Ruchi",
//       "email": "ruchi@gmail.com",
//       "joinDate": "2023-02-08",
//     }
//   ];

//   // sort users by joinDate: ascending
//   final sortedUsersAsc = users.map((user) => user).toList()
//     ..sort((a, b) =>
//         DateTime.parse(a["joinDate"]).compareTo(DateTime.parse(b["joinDate"])));

//   // sort users by joinDate: descending
//   final sortedUsersDesc = users.map((user) => user).toList()
//     ..sort((a, b) =>
//         DateTime.parse(b["joinDate"]).compareTo(DateTime.parse(a["joinDate"])));

//   print("Sorted users by ascending joinDate:");
//   print(sortedUsersAsc);

//   print("Sorted users by descending joinDate:");
//   print(sortedUsersDesc);
// }