import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_player/radio_player.dart';
import 'package:raydeo_one/application/common_widgets/showmetadata.dart';
import 'package:share_plus/share_plus.dart';
import 'package:volume_controller/volume_controller.dart';
import '../common_widgets/chatpage.dart';
import '../common_widgets/snackbar.dart';
import '../../utils/constant.dart';

Widget musicPlayer(appBarHeight, setState) {
  RadioPlayer radioPlayer = RadioPlayer();
  return SafeArea(
    child: FutureBuilder(
        future: radioPlayer.getArtworkImage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final screensize = MediaQuery.of(context).size;
          Image artwork;
          if (snapshot.hasData) {
            artwork = snapshot.data;
            print("hbshscccs$artwork${snapshot.data}");
          } else {
            print("hfnfkne");
            artwork = Image(
                image: NetworkImage(
              '$imgurlOfChannel',
            ));
          }
          print("hbshscccs2$metadata");
          return Obx(
            () => Stack(children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: screensize.height -
                      (appBarHeight + MediaQuery.of(context).viewPadding.top),
                  width: screensize.width * 1,
                  decoration: BoxDecoration(
                    color: isDark == true ? Colors.grey.shade900 : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              tapped.value = false;
                              displayfavlist =
                                  favouritelist!.get("favlist") ?? [];
                              controllerStack.animateToHeight(
                                  state: PanelState.MIN,
                                  duration: const Duration(milliseconds: 30));
                            },
                            child: Icon(
                              Icons.keyboard_double_arrow_down_rounded,
                              size: 35,
                              color: maincolor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screensize.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                '$catgOfChannel',
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: isDark == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                '$nameOfChannel',
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: isDark == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              SizedBox(
                                height: screensize.height * 0.005,
                              ),
                              if (status != 'Offline')
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: isDark == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        Obx(
                                          () => Text(
                                            " ${subcount}",
                                            style: TextStyle(
                                                color: isDark == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              metadata!.isNotEmpty
                                  ? const showMetaData()
                                  : const SizedBox(
                                      height: 0,
                                    )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screensize.height * 0.005,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 1),
                                  ],
                                  //   shape: const BeveledRectangleBorder(
                                  //   borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //   side: BorderSide(color: Colors.black, width: 4),
                                  // ),
                                  borderRadius: BorderRadius.circular(20)),
                              width: screensize.width * .8,
                              height: screensize.width * .7,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: status != 'Offline'
                                    ? FadeInImage(
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/Raydeo.ONE512.png',
                                          );
                                        },
                                        placeholder: const AssetImage(
                                            "assets/images/Raydeo.ONE512.png"),
                                        image: NetworkImage("$imgurlOfChannel"),
                                        fit: BoxFit.fill,
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            "assets/images/Raydeo.ONE512.png")),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screensize.height * 0.015,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        width: screensize.width * .8,
                        height: screensize.height * .18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Share.share(
                                        "Hi, I am listening to radio using the Radio.ONE application. Download and enjoy the application https://theradio.one",
                                      );
                                    },
                                    icon: Icon(
                                      Icons.share_rounded,
                                      color: maincolor,
                                      size: 35,
                                    )),
                                InkWell(
                                    onTap: () {
                                      print("qwerty");
                                      if (status != 'Offline') {
                                        setState(() {
                                          isPlaying
                                              ? radioPlayer.pause()
                                              : radioPlayer.play();
                                        });
                                        if (cancel.value == true) {
                                          cancel.value = !cancel.value;
                                        } else {
                                          cancel.value = true;
                                        }
                                      } else {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          snackbar(context);
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: maincolor),
                                      child: isPlaying
                                          ? loader.value == true
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: isDark == true
                                                      ? Colors.white
                                                      : Colors.black,
                                                ))
                                              : Icon(
                                                  Icons.pause_rounded,
                                                  color: isDark == true
                                                      ? Colors.white
                                                      : Colors.black,
                                                  size: 35,
                                                )
                                          : Icon(
                                              Icons.play_arrow_rounded,
                                              color: isDark == true
                                                  ? Colors.white
                                                  : Colors.black,
                                              size: 35,
                                            ),
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      if (displayfavlist.isNotEmpty) {
                                        if (addFavourite == true) {
                                          favlist = favouritelist!.get(
                                                "favlist",
                                              ) ??
                                              [];
                                          print(
                                              "favlistsecondlist${favlist.length}");

                                          for (int x = 0;
                                              x < favlist.length;
                                              x++) {
                                            print(
                                                "channel_name : ${favlist[x]["channel_name"]}");
                                            if (favlist[x]["channel_name"]
                                                    .toString() ==
                                                "$nameOfChannel") {
                                              setState(() {
                                                print(
                                                    "matched  ##################");
                                                favlist.removeAt(x);
                                                favouritelist!
                                                    .put("favlist", []);
                                                favouritelist!
                                                    .put("favlist", favlist);
                                                addFavourite = !addFavourite;
                                                displayfavlist = favouritelist!
                                                        .get("favlist") ??
                                                    [];
                                              });
                                            }
                                          }
                                        } else {
                                          setState(() {
                                            favlist = favouritelist!.get(
                                                  "favlist",
                                                ) ??
                                                [];
                                            favouritelist!.put("favlist", []);

                                            favlist.add(favdata);
                                            favouritelist!
                                                .put("favlist", favlist);
                                            addFavourite = !addFavourite;
                                            displayfavlist =
                                                favouritelist!.get("favlist") ??
                                                    [];
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          favlist = favouritelist!.get(
                                                "favlist",
                                              ) ??
                                              [];
                                          favouritelist!.put("favlist", []);
                                          favlist.add(favdata);
                                          favouritelist!
                                              .put("favlist", favlist);
                                          addFavourite = !addFavourite;
                                        });
                                        setState(() {
                                          displayfavlist =
                                              favouritelist!.get("favlist") ??
                                                  [];
                                        });
                                      }
                                    },
                                    icon: addFavourite == true
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 35,
                                          )
                                        : Icon(
                                            Icons.favorite_border_rounded,
                                            color: maincolor,
                                            size: 35,
                                          )),
                              ],
                            ),
                            SizedBox(
                              width: screensize.width * .8,
                              height: screensize.height * .05,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.volume_down_rounded,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: screensize.width * .64,
                                    child: Slider(
                                      activeColor: maincolor,
                                      inactiveColor: Colors.blueGrey,
                                      min: 0,
                                      max: 1,
                                      onChanged: (double value) {
                                        setState(() {
                                          setVolumeValue = value;
                                          VolumeController()
                                              .setVolume(setVolumeValue);
                                        });
                                      },
                                      value: setVolumeValue,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.volume_up_rounded,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      loader.value == true
                          ? Text("Loading Please wait .....",
                              style: Theme.of(context).textTheme.bodyLarge)
                          : const SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        height: screensize.height * 0.015,
                      ),
                    ],
                  ),
                ),
              ),
              tapped.value == true
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: const Color.fromARGB(239, 186, 185, 185),
                            height: screensize.height * 0.95,
                            width: screensize.height * 1,
                            child: const ChatPage(),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ]),
          );
        }),
  );
}
