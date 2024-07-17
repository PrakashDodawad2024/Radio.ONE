import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_player/radio_player.dart';
import 'package:raydeo_one/main.dart';
import '../common_widgets/display_image.dart';
import '../common_widgets/snackbar.dart';
import '../common_methods/checkisfavourite.dart';
import 'homepage.dart';
import '../../mqtt/mqttconnection.dart';
// ignore: unused_import
import '../../mqtt/mqttregister.dart';
import '../../utils/constant.dart';

class CustomSearchDelegate extends SearchDelegate {
  final Function setState;

  CustomSearchDelegate({
    Key? key,
    required this.setState,
  });
  final RadioPlayer _radioPlayer = RadioPlayer();

  List searchTerms = titlelist;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          color: maincolor,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        color: maincolor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    List matchQuery = [];
    for (var title in searchTerms) {
      if (title.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(title);
      }
    }
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView.builder(
        itemCount: alldata.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return (matchQuery
                  .contains(alldata[index]['channel_name'].toString()))
              ? InkWell(
                  onTap: () async {
                    close(context, null);
                    if (status != 'Offline') {
                      if (idOfChannel.value != "") {
                        await MQTTConnections()
                            .unsubscribeToChannel("$idOfChannel");
                        controllerStack.animateToHeight(
                            state: PanelState.MAX,
                            duration: const Duration(milliseconds: 30));
                      }
                      controllerStack.animateToHeight(
                          state: PanelState.MAX,
                          duration: const Duration(milliseconds: 30));
                      cancel.value = false;
                      _radioPlayer.stop();
                      setState(() {
                        metadata = [];
                      });
                      loader.value = true;
                      Future.delayed(const Duration(seconds: 3), () {
                        loader.value = false;
                      });
                      currentindx =
                          alldata[index]["total_number_of_subscribers"];
                      nameOfChannel.value = alldata[index]["channel_name"];
                      descOfChannel.value =
                          alldata[index]["channel_description"];
                      idOfChannel.value = alldata[index]["channel_id"];
                      urlOfChannel.value = alldata[index]["channel_stream_url"];
                      imgurlOfChannel.value =
                          alldata[index]["channel_image_url"];
                      catgOfChannel.value = alldata[index]["channel_category"];
                      subcount = 1.obs;
                      await MQTTConnections()
                          .MQTTSubscribeMethod("$idOfChannel");
                      await checkIsFavourite(setState);
                      openmini.value = true;
                      await radioPlayer.setChannel(
                        title: '$nameOfChannel',
                        url: '$urlOfChannel',
                        imagePath: '$imgurlOfChannel',
                      );
                      Future.delayed(const Duration(milliseconds: 5), () {
                        radioPlayer.play();
                      });

                      radioPlayer.stateStream.listen((value) {
                        print("sdgxcfhjbkn:$value");
                        setState(() {
                          isPlaying = value;
                        });
                      });

                      radioPlayer.metadataStream.listen((value) {
                        print("hbshscccs${metadata}");
                        setState(() {
                          metadata = value;
                        });
                        print("hbshscccs${metadata}");
                      });
                      print("nameOfChannel:${nameOfChannel}");
                      print("idOfChannel:${idOfChannel}");
                      print("descOfChannel:${descOfChannel}");
                    } else {
                      snackbar(context);
                    }
                  },
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: ListTile(
                      leading: DisplayImage(
                        url: '${alldata[index]['channel_image_url']}',
                        width: screensize.width * .12,
                        height: screensize.width * .12,
                      ),
                      title: Text(alldata[index]['channel_name']),
                      subtitle: Text(alldata[index]['channel_category']),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 0,
                );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    List matchQuery = [];
    for (var title in searchTerms) {
      if (title.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(title);
      }
    }
    return matchQuery.isEmpty
        ? Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
                child: Text("No Match Found",
                    style: Theme.of(context).textTheme.headlineSmall)),
          )
        : Container(
            color: Theme.of(context).backgroundColor,
            child: ListView.builder(
              itemCount: alldata.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return (matchQuery.contains(
                            alldata[index]['channel_name'].toString()) ||
                        matchQuery.contains(
                            alldata[index]['channel_category'].toString()))
                    ? InkWell(
                        onTap: () async {
                          close(context, null);
                          if (status != 'Offline') {
                            if (idOfChannel != "") {
                              await MQTTConnections()
                                  .unsubscribeToChannel("$idOfChannel");
                              controllerStack.animateToHeight(
                                  state: PanelState.MAX,
                                  duration: const Duration(milliseconds: 30));
                            }
                            controllerStack.animateToHeight(
                                state: PanelState.MAX,
                                duration: const Duration(milliseconds: 30));
                            cancel.value = false;
                            _radioPlayer.stop();
                            setState(() {
                              metadata = [];
                            });
                            loader.value = true;
                            Future.delayed(const Duration(seconds: 3), () {
                              loader.value = false;
                            });
                            currentindx =
                                alldata[index]["total_number_of_subscribers"];
                            favdata = alldata[index];
                            nameOfChannel.value =
                                alldata[index]["channel_name"];
                            descOfChannel.value =
                                alldata[index]["channel_description"];
                            idOfChannel.value = alldata[index]["channel_id"];
                            urlOfChannel.value =
                                alldata[index]["channel_stream_url"];
                            imgurlOfChannel.value =
                                alldata[index]["channel_image_url"];
                            catgOfChannel.value =
                                alldata[index]["channel_category"];

                            subcount = 1.obs;
                            await MQTTConnections()
                                .MQTTSubscribeMethod("$idOfChannel");
                            await checkIsFavourite(setState);
                            await radioPlayer.setChannel(
                              title: '$nameOfChannel',
                              url: '$urlOfChannel',
                              imagePath: '$imgurlOfChannel',
                            );
                            Future.delayed(const Duration(milliseconds: 5), () {
                              radioPlayer.play();
                            });

                            radioPlayer.stateStream.listen((value) {
                              print("sdgxcfhjbkn:$value");
                              setState(() {
                                isPlaying = value;
                              });
                            });

                            radioPlayer.metadataStream.listen((value) {
                              print("hbshscccs${metadata}");
                              setState(() {
                                metadata = value;
                              });
                              print("hbshscccs${metadata}");
                            });

                            print("nameOfChannel:${nameOfChannel}");
                            print("idOfChannel:${idOfChannel}");
                            print("descOfChannel:${descOfChannel}");
                            openmini.value = true;
                          } else {
                            snackbar(context);
                          }
                        },
                        child: ListTile(
                          leading: DisplayImage(
                            url: '${alldata[index]['channel_image_url']}',
                            width: screensize.width * .12,
                            height: screensize.width * .12,
                          ),
                          title: Text(alldata[index]['channel_name']),
                          subtitle: Text(alldata[index]['channel_category']),
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                      );
              },
            ),
          );
  }
}
