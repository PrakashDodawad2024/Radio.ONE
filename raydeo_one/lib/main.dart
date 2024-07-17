import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:raydeo_one/themes/theme_constant.dart';
import 'package:raydeo_one/onboardingpages/splashscreen.dart';
import 'package:raydeo_one/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/amplifyconfiguration.dart';
import 'config/firebase_options.dart';
import 'mqtt/mqttconnection.dart';
import 'mqtt/mqttregister.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
// ignore: unused_import
import 'package:volume_controller/volume_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  isFirsttime = sharedPreferences.getBool("isFirsttime") ?? true;
  isRegistered = sharedPreferences.getBool("isRegistered") ?? false;
  await Hive.initFlutter();
  channel = await Hive.openBox("channel");
  clientdetailBox = await Hive.openBox("clientdetailBox");
  allmessages = await Hive.openBox("allmessages");
  statiomessages = await Hive.openBox("statiomessages");
  favouritelist = await Hive.openBox("favouritelist");
  accountdetails = await Hive.openBox("accountdetails");

  initializeDateFormatting().then((_) => SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then((value) => runApp(const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  StreamSubscription? _streamSubscription;
  bool amplifyConfigured = false;
  bool isalreadysignin = false;

  @override
  void initState() {
    super.initState();
    deviceThemeListener();
    _configureAmplify();
    callmqtt();
    VolumeController().listener((volume) {
      setState(() => volumeListenerValue = volume);
    });
    VolumeController().getVolume().then((volume) => setVolumeValue = volume);
  }

  void _configureAmplify() async {
    print("***********************************************");
    if (!mounted) return;

    await Amplify.addPlugins([AmplifyAPI()]);
    try {
      await Amplify.configure(amplifyconfig);
      print('Configured Done!!');

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
    } on AmplifyAlreadyConfiguredException {
      print('Already Configured!!');
    }
    try {
      setState(() {
        amplifyConfigured = true;
      });
    } catch (e) {
      print('error:$e');
    }
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    _streamSubscription?.cancel();
    super.dispose();
  }

  deviceThemeListener() {
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      final brightness = window.platformBrightness;
      print("brightness:$brightness");
      if (brightness == Brightness.dark) {
        setState(() {
          isDark = true;
        });
      } else {
        setState(() {
          isDark = false;
        });
      }
    };
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("APP IS RESUMED!!!");
        print("picker is off");
        mqttConnection();
        break;
      case AppLifecycleState.inactive:
        listenerObject?.cancel();
        break;
      case AppLifecycleState.paused:
        listenerObject?.cancel();
        break;
      case AppLifecycleState.detached:
        print("detached");
        listenerObject?.cancel();
        break;
    }
  }

  callmqtt() async {
    if (isRegistered == false) {
      await Mqtt().registerUserMethod();
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var connectionDetail = await jsonDecode(
          "${sharedPreferences.getString('allconnectionData')}");
      await MQTTConnections().connectToMQTTMethod(
          connectionDetail['ip_address'],
          connectionDetail['port'],
          connectionDetail['user_name'],
          connectionDetail['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radio.ONE',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreenPage(),
    );
  }

  mqttConnection() async {
    if (isRegistered == false) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var connectionDetail =
          jsonDecode("${sharedPreferences.getString('allconnectionData')}");
      MQTTConnections().connectToMQTTMethod(
          connectionDetail['ip_address'],
          connectionDetail['port'],
          connectionDetail['user_name'],
          connectionDetail['password']);
    }
  }
}
