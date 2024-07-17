import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:raydeo_one/application/landingpages/categorylist.dart';
import '../common_widgets/alert_dailogue.dart';
import '../common_widgets/appbarwidget.dart';
import '../common_widgets/favourite_empty.dart';
import 'favouritepage.dart';
import 'minimusic.dart';
import 'musicplayer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'viewmore.dart';
import '../../utils/constant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    displayfavlist = favouritelist!.get("favlist") ?? [];
    print("categories:$categorylist");
    connectivity.initialise();
    connectivity.myStream.listen((source) {
      if (!mounted) {
        return;
      } else {
        setState(() => surce = source);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    PreferredSize appBar = PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBarWidget(context, setState));
    final appBarHeight = appBar.preferredSize.height;
    print('status**********:${status}');
    switch (surce.keys.toList()[0]) {
      case ConnectivityResult.none:
        status = "Offline";
        isDataConnected = false;
        radioPlayer.stop();
        break;
      case ConnectivityResult.mobile:
        status = "Mobile: Online";
        isDataConnected = true;
        break;
      case ConnectivityResult.wifi:
        status = "WiFi: Online";
        isDataConnected = true;
        break;
      case ConnectivityResult.ethernet:
        status = "Ethernet: Online";
        isDataConnected = true;
        break;
    }
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return alertDialog(context);
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: allmessages!.listenable(),
              builder: (context, value, child) {
                final allresponse = allmessages!.get("allmessages");
                // print("allresponvvbvbse$allresponse");
                if (allresponse != null) {
                  final decodeddata =
                      jsonDecode(allresponse["channel_message"]);
                  final alldecodeddata = jsonDecode(decodeddata["description"]);
                  alldata = alldecodeddata;
                  // print("alldaddddta$alldata");
                  for (int i = 0; i < alldata.length; i++) {
                    if (!categorylist
                        .contains(alldata[i]["channel_category"])) {
                      categorylist.add(alldata[i]["channel_category"]);
                      print("categorylist$categorylist");
                    }
                    homepageloader.value = false;
                    if (!titlelist.contains(alldata[i]["channel_name"]) ||
                        !titlelist.contains(alldata[i]["channel_category"])) {
                      titlelist.add(alldata[i]["channel_name"].toString());
                      titlelist.add(alldata[i]["channel_category"].toString());
                      print("titlelist$titlelist");
                    }
                  }
                }
                return homepageloader.value == true
                    ? Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(
                            color: maincolor,
                          ),
                        ),
                      )
                    : Stack(
                        children: <Widget>[
                          Container(
                            height: screensize.height * 1,
                            padding: const EdgeInsets.only(top: 5),
                            color: Colors.grey.shade200,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int j = 0;
                                          j < categorylist.length;
                                          j++)
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: (categorylist.isNotEmpty)
                                                ? Card(
                                                    color: const Color.fromARGB(
                                                        255, 242, 242, 242),
                                                    elevation: 0,
                                                    child: getSortedChannels(j),
                                                  )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )),
                                      miniplayerOpen.value != null
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.115,
                                            )
                                          : const SizedBox(
                                              height: 0,
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          openmini.value == true
                              ? Miniplayer(
                                  controller: controllerStack,
                                  backgroundColor: maincolor,
                                  minHeight: 100,
                                  maxHeight: screensize.height * 1,
                                  builder: (height, percentage) {
                                    if (height <= 100) {
                                      displayfavlist =
                                          favouritelist!.get("favlist") ?? [];
                                    }
                                    return ClipRect(
                                      child: BackdropFilter(
                                          filter: ui.ImageFilter.blur(
                                              sigmaX: 100.0,
                                              sigmaY: 100.0,
                                              tileMode: TileMode.mirror),
                                          child: (height != 100)
                                              ? musicPlayer(
                                                  appBarHeight, setState)
                                              : miniPlayerMusic(setState)),
                                    );
                                  })
                              : const SizedBox(
                                  height: 0,
                                ),
                        ],
                      );
              }),
        ),
      ),
    );
  }

  getSortedChannels(j) {
    final screensize = MediaQuery.of(context).size;
    try {
      bool checkPieOpenClose = (closeRest.contains(j)) ? true : false;
      return ExpansionWidget(
          onSaveState: (isExpanded) => checkPieOpenClose = isExpanded,
          onExpansionChanged: (value) {
            if (value == true) {
              setState(() {
                closeRest = [];
                closeRest.add(j);
              });
            }
          },
          onRestoreState: () => checkPieOpenClose,
          maintainState: true,
          duration: const Duration(milliseconds: 350),
          // initiallyExpanded:
          //     (jsonDecode(widget.decodedItem['description']).length == 1)
          //         ? true
          //         : false,
          titleBuilder:
              (animationValue, easeInValue, isExpanded, toggleFunction) {
            return GestureDetector(
              onTap: () {
                toggleFunction(animated: true);
                catgChannel.value = categorylist[j];
                print("${categorylist[j]} catgChannel$catgChannel");
                viewmorelist.value = [];
                for (int k = 0; k < alldata.length; k++) {
                  if (alldata[k]['channel_category'].contains(catgChannel)) {
                    viewmorelist.add(alldata[k]);
                  }
                  print("catgChannel$viewmorelist");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Theme.of(context).backgroundColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screensize.width * 0.925,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${categorylist[j]}",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          categorylist[j] == "Favourites"
                              ? isExpanded == true && displayfavlist.length > 10
                                  ? SizedBox(
                                      height: screensize.height * 0.035,
                                      width: screensize.height * 0.125,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => viewMore(
                                                context, setState, catgChannel),
                                          ));
                                        },
                                        child: Text(
                                          "View All",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: maincolor),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    )
                              : isExpanded == true && viewmorelist.length > 10
                                  ? SizedBox(
                                      height: screensize.height * 0.035,
                                      width: screensize.height * 0.125,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => viewMore(
                                                context, setState, catgChannel),
                                          ));
                                        },
                                        child: Text(
                                          "View All",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: maincolor),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    )
                        ],
                      ),
                    ),
                    // Transform.rotate(
                    //   angle: math.pi * animationValue + 1.55,
                    //   alignment: Alignment.center,
                    //   child: const Icon(
                    //     Icons.arrow_forward_ios,
                    //     size: 18,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
          content: categorylist[j] == "Favourites"
              ? displayfavlist.isNotEmpty
                  ? FavouritePage(setState, context)
                  : const NoFavourites()
              : categoryList(context, setState, j));
    } catch (e) {
      print("pie error$e");
      return const Text("NO Data");
    }
  }
}
