import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_player/radio_player.dart';
import '../common_widgets/display_image.dart';
import '../common_widgets/snackbar.dart';
import '../../utils/constant.dart';

Widget miniPlayerMusic(setState) {
  RadioPlayer radioPlayer = RadioPlayer();
  return SafeArea(
    child: FutureBuilder(
        future: radioPlayer.getArtworkImage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final screensize = MediaQuery.of(context).size;
          Image artwork;
          if (snapshot.hasData) {
            artwork = snapshot.data;
          } else {
            artwork = Image(
                image: NetworkImage(
              '$imgurlOfChannel',
              // fit: BoxFit.cover,
            ));
          }
          return Obx(
            () => Stack(children: [
              InkWell(
                onTap: () {
                  controllerStack.animateToHeight(
                      state: PanelState.MAX,
                      duration: const Duration(milliseconds: 30));
                },
                child: Container(
                  color: Colors.black12,
                  // color: Theme.of(context).backgroundColor,
                  child: Container(
                    width: screensize.width * 1,
                    decoration: BoxDecoration(
                        color: isDark == true
                            ? Colors.grey.shade900
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screensize.height * .005,
                        ),
                        InkWell(
                          onTap: () {
                            controllerStack.animateToHeight(
                                state: PanelState.MAX,
                                duration: const Duration(milliseconds: 30));
                          },
                          child: Icon(
                            Icons.keyboard_double_arrow_up_rounded,
                            size: 26,
                            color: maincolor,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screensize.width * .035,
                            ),
                            DisplayImage(
                              url: '${imgurlOfChannel}',
                              width: screensize.width * .12,
                              height: screensize.width * .12,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$nameOfChannel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDark == true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                Text(
                                  '$catgOfChannel',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark == true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                  onTap: () {
                                    if (status != 'Offline') {
                                      miniplayerOpen.value =
                                          !miniplayerOpen.value;
                                      setState(() {
                                        print("tapppingggggg$isPlaying");

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
                            ),
                            SizedBox(
                              width: screensize.width * .025,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        }),
  );
}
