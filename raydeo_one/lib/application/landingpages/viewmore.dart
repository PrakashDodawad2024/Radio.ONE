import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_player/radio_player.dart';
import 'package:raydeo_one/application/common_widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_methods/checkisfavourite.dart';
import '../common_methods/setradioplayer.dart';
import '../common_widgets/display_image.dart';
import '../common_widgets/text.dart';
import '../../mqtt/mqttconnection.dart';
import '../../utils/constant.dart';

Widget viewMore(context, setState, catgChannel) {
  final screensize = MediaQuery.of(context).size;
  RadioPlayer radioPlayer = RadioPlayer();
  return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("$catgChannel",
            style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: true,
        iconTheme: IconThemeData(color: maincolor),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: catgChannel != "Favourites"
          ? Container(
              height: screensize.height * 1,
              width: screensize.width * 1,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                color: isDark == true ? Colors.grey.shade900 : Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: screensize.width * 1,
                  height: screensize.height * 1,
                  child: GridView.builder(
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1 / 1.3),
                    shrinkWrap: true,
                    itemCount: viewmorelist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: screensize.height * 0.24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  if (status != 'Offline') {
                                    if (idOfChannel.isNotEmpty) {
                                      await MQTTConnections()
                                          .unsubscribeToChannel("$idOfChannel");
                                    }

                                    controllerStack.animateToHeight(
                                        state: PanelState.MAX,
                                        duration:
                                            const Duration(milliseconds: 30));
                                    cancel.value = false;
                                    radioPlayer.stop();
                                    setState(() {
                                      metadata = [];
                                    });
                                    loader.value = true;
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      loader.value = false;
                                    });
                                    print("currentindx:$currentindx");
                                    favdata = viewmorelist[index];

                                    nameOfChannel.value =
                                        viewmorelist[index]["channel_name"];
                                    descOfChannel.value = viewmorelist[index]
                                        ["channel_description"];
                                    catgOfChannel.value =
                                        viewmorelist[index]["channel_category"];
                                    idOfChannel.value =
                                        viewmorelist[index]["channel_id"];
                                    urlOfChannel.value = viewmorelist[index]
                                        ["channel_stream_url"];
                                    imgurlOfChannel.value = viewmorelist[index]
                                        ["channel_image_url"];
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

                                    Future.delayed(
                                        const Duration(seconds: 5), () {});
                                    var resp = await MQTTConnections()
                                        .getChannelDetails("$idOfChannel");
                                    print(
                                        "spdata:${resp["total_number_of_subscribers"]}name${resp["channel_id"]}");

                                    print("tacsvvdcvaadcad");
                                    await setRadioPlayer(setState);
                                  } else {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      snackbar(context);
                                    });
                                  }
                                },
                                child: DisplayImage(
                                  url:
                                      '${viewmorelist[index]['channel_image_url']}',
                                  width: screensize.width * .27,
                                  height: screensize.height * .129,
                                )),
                            SizedBox(
                              height: screensize.height * .015,
                            ),
                            SizedBox(
                              width: screensize.width * .26,
                              child: Column(
                                children: [
                                  Texts(
                                    text:
                                        "${viewmorelist[index]['channel_name']}",
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : displayfavlist.isNotEmpty
              ? Container(
                  height: screensize.height * 1,
                  width: screensize.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: isDark == true ? Colors.grey.shade900 : Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: screensize.width * 1,
                      height: screensize.height * 1,
                      child: GridView.builder(
                        physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 1 / 1.4),
                        shrinkWrap: true,
                        itemCount: displayfavlist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: screensize.height * 0.24,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    if (status != 'Offline') {
                                      if (idOfChannel.isNotEmpty) {
                                        await MQTTConnections()
                                            .unsubscribeToChannel(
                                                "$idOfChannel");
                                      }

                                      controllerStack.animateToHeight(
                                          state: PanelState.MAX,
                                          duration:
                                              const Duration(milliseconds: 30));
                                      cancel.value = false;
                                      radioPlayer.stop();
                                      setState(() {
                                        metadata = [];
                                      });
                                      loader.value = true;
                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        loader.value = false;
                                      });
                                      print("currentindx:$currentindx");
                                      favdata = displayfavlist[index];

                                      nameOfChannel.value =
                                          displayfavlist[index]["channel_name"];
                                      descOfChannel.value =
                                          displayfavlist[index]
                                              ["channel_description"];
                                      catgOfChannel.value =
                                          displayfavlist[index]
                                              ["channel_category"];
                                      idOfChannel.value =
                                          displayfavlist[index]["channel_id"];
                                      urlOfChannel.value = displayfavlist[index]
                                          ["channel_stream_url"];
                                      imgurlOfChannel.value =
                                          displayfavlist[index]
                                              ["channel_image_url"];
                                      openmini.value = true;
                                      subcount = 1.obs;

                                      // startminiplayerOpen(urlOfChannel);
                                      Future.delayed(
                                          const Duration(seconds: 2));
                                      var qwe = await MQTTConnections()
                                          .MQTTSubscribeMethod("$idOfChannel");

                                      await checkIsFavourite(setState);
                                      print("spdata:${idOfChannel}");
                                      print("favdfgdcg:${displayfavlist}");
                                      Future.delayed(
                                          const Duration(seconds: 2));

                                      final SharedPreferences
                                          sharedPreferences =
                                          await SharedPreferences.getInstance();

                                      print(
                                          "spdata:${sharedPreferences.getString('device_id')} ");

                                      Future.delayed(
                                          const Duration(seconds: 5), () {});
                                      var resp = await MQTTConnections()
                                          .getChannelDetails("$idOfChannel");
                                      print(
                                          "spdata:${resp["total_number_of_subscribers"]}name${resp["channel_id"]}");
                                      // subcount.value =
                                      //     resp["total_number_of_subscribers"];
                                      print("tacsvvdcvaadcad");
                                      await setRadioPlayer(setState);

                                      Navigator.pop(context);
                                    } else {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        snackbar(context);
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: screensize.width * .3,
                                    height: screensize.height * .129,
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Card(
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: status != 'Offline'
                                            ? Image.network(
                                                "${displayfavlist[index]['channel_image_url']}")
                                            : const Image(
                                                image: AssetImage(
                                                    "assets/images/Raydeo.ONE512.png")),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screensize.height * .015,
                                ),
                                SizedBox(
                                  width: screensize.width * .26,
                                  child: Column(
                                    children: [
                                      Texts(
                                          text:
                                              "${displayfavlist[index]['channel_name']}",
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
                  ),
                )
              : const SizedBox(
                  height: 0,
                ));
}
