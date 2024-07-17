import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant.dart';
import '../common_methods/checkisfavourite.dart';
import '../common_methods/setradioplayer.dart';
import '../../mqtt/mqttconnection.dart';
import '../common_widgets/display_image.dart';
import '../common_widgets/snackbar.dart';
import '../common_widgets/text.dart';
import 'homepage.dart';

Widget FavouritePage(setState, context) {
  final screensize = MediaQuery.of(context).size;
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
      color: isDark == true ? Colors.grey.shade900 : Colors.white,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    child: Column(
      children: [
        SizedBox(
          width: screensize.width * 1,
          height: screensize.height * 0.22,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: displayfavlist.length,
            itemBuilder: (context, index) {
              return Container(
                color: isDark == true ? Colors.grey.shade900 : Colors.white,
                margin: const EdgeInsets.only(right: 5, left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () async {
                          if (status != 'Offline') {
                            controllerStack.animateToHeight(
                                state: PanelState.MAX,
                                duration: const Duration(milliseconds: 30));
                            cancel.value = false;
                            if (idOfChannel.isNotEmpty) {
                              await MQTTConnections()
                                  .unsubscribeToChannel("$idOfChannel");
                            }
                            radioPlayer.stop();
                            setState(() {
                              metadata = [];
                            });

                            loader.value = true;
                            Future.delayed(const Duration(seconds: 5), () {
                              loader.value = false;
                            });
                            print("currentindx:$currentindx");
                            favdata = displayfavlist[index];

                            nameOfChannel.value =
                                displayfavlist[index]["channel_name"];
                            descOfChannel.value =
                                displayfavlist[index]["channel_description"];
                            catgOfChannel.value =
                                displayfavlist[index]["channel_category"];
                            idOfChannel.value =
                                displayfavlist[index]["channel_id"];
                            urlOfChannel.value =
                                displayfavlist[index]["channel_stream_url"];
                            imgurlOfChannel.value =
                                displayfavlist[index]["channel_image_url"];
                            openmini.value = true;
                            subcount = 1.obs;

                            Future.delayed(const Duration(seconds: 2));
                            var qwe = await MQTTConnections()
                                .MQTTSubscribeMethod("$idOfChannel");

                            await checkIsFavourite(setState);
                            print("spdata:${idOfChannel}");
                            print("favdfgdcg:${displayfavlist}");
                            Future.delayed(const Duration(seconds: 2));

                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();

                            print(
                                "spdata:${sharedPreferences.getString('device_id')} ");

                            Future.delayed(const Duration(seconds: 5), () {});
                            var resp = await MQTTConnections()
                                .getChannelDetails("$idOfChannel");
                            print(
                                "spdata:${resp["total_number_of_subscribers"]}name${resp["channel_id"]}");

                            print("tacsvvdcvaadcad");
                            setRadioPlayer(
                              setState,
                            );
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              snackbar(context);
                            });
                          }
                        },
                        child: DisplayImage(
                          url: '${displayfavlist[index]['channel_image_url']}',
                          width: screensize.width * .27,
                          height: screensize.height * .129,
                        )),
                    SizedBox(
                      height: screensize.height * .018,
                    ),
                    SizedBox(
                      width: screensize.width * .27,
                      child: Column(
                        children: [
                          Texts(
                              text: "${displayfavlist[index]['channel_name']}",
                              size: 12),
                          Texts(
                              text:
                                  "${displayfavlist[index]['channel_category']}",
                              size: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
