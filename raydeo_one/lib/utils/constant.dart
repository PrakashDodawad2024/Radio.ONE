import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_player/radio_player.dart';

import '../application/common_widgets/connectivity.dart';

int currentindx = 0;
int changeindex = 0;
RxBool openmini = false.obs;
bool loadingdata = true;
RxString currentPlaying = "".obs;
RxInt subcount = 1.obs;
RxInt curindex = 0.obs;
int nextindex = 0;
RxBool playing = false.obs;
RxBool empty = false.obs;
RxBool otpsent = false.obs;
RxBool isloading = false.obs;
RxBool homepageloader = true.obs;
RxBool loader = false.obs;
RxBool miniplay = false.obs;
RxBool cancel = false.obs;
RxBool tapped = false.obs;
RxBool onplay = false.obs;
RxBool onpause = false.obs;
RxBool tapemail = false.obs;
RxBool shownowplaying = false.obs;
RxBool tapmob = false.obs;
RxBool opennew = false.obs;
RxBool favpage = false.obs;
RxBool nameuser = false.obs;
RxBool copytext = false.obs;
bool verified = accountdetails!.get(
      "MobNoVerified",
    ) ??
    false;
bool addFavourite = false;
List alldata = [];
List favlist = [];
List displayfavlist = [];
String username = accountdetails!.get(
      "username",
    ) ??
    "Your Name";
String mobileNumber = accountdetails!.get(
      "mobileNumber",
    ) ??
    "Mobile Number";
RxList stationdata = [].obs;
List categories = [];
String changename = "";
RxList categorylist = [
  "Newly Added",
  "Favourites",
].obs;
RxList titlelist = [].obs;
RxList viewmorelist = [].obs;
List urls = [];
Color bgColor = Colors.purple;
Color maincolor = const Color.fromARGB(255, 152, 188, 145);
bool? isFirsttime;
bool? isRegistered;
bool Firsttimee = true;
Box? channel;
Box? clientdetailBox;
Box? allmessages;
Box? accountdetails;
Box? statiomessages;
Box? favouritelist;
String selected = "";
RxString nameOfChannel = ''.obs;
RxString descOfChannel = ''.obs;
RxString urlOfChannel = ''.obs;
RxString imgurlOfChannel = ''.obs;
RxString idOfChannel = ''.obs;
RxString catgOfChannel = ''.obs;
RxString catgChannel = 'Newly Added'.obs;
bool isDataConnected = true;
bool viewmore = false;
bool isDark =
    SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
double volumeListenerValue = 0;
double getVolume = 0;
double setVolumeValue = 0;
final controllerStack = MiniplayerController();
RxBool miniplayerOpen = false.obs;
Map favdata = {};
int currentindex = 0;
Map surce = {ConnectivityResult.none: false};
MyConnectivity connectivity = MyConnectivity.instance;
String status = "Mobile: Online";
RxBool miniplayerOpened = false.obs;
RadioPlayer radioPlayer = RadioPlayer();
bool isPlaying = false;
List<String>? metadata = [];
List closeRest = [0];
Uri? currentURI;
Object? err;
StreamSubscription? streamSubscription;
