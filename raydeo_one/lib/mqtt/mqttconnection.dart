import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:event/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../utils/constant.dart';

String? finalConnectionStatus;
MqttServerClient? clientDetails;
BuildContext? newcontext;
var maxTries = 3;
var currentTry = 1;
StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>? listenerObject;

class MQTTConnections {
  Future connectToMQTTMethod(ipadres, port, username, pass) async {
    print("ipadres:$ipadres");
    print("port:$port");
    print("username:$username");
    print("pass:$pass");
    print("Connecting to mqtt");

    try {
      clientDetails = MqttServerClient.withPort(
        ipadres,
        username,
        port,
      );
      print("clientDetails${clientDetails!.clientIdentifier}");

      clientDetails!.logging(on: true);
      // MqttConnectFlags();
      clientDetails!.onConnected = () => onConnected();
      clientDetails!.onDisconnected = () => onDisconnected();
      clientDetails!.onSubscribed = ((topic) => {
            print("**Subscribed To The Topic ${topic}*"),
          });
      clientDetails!.onSubscribeFail = ((topic) => {
            print("*Failed To Subscribe To Topic ${topic}**"),
          });
      clientDetails!.clientIdentifier = username;
      // clientDetails!.onAutoReconnect = onAutoReconnect();
      clientDetails!.autoReconnect = false;

      final connMessage = MqttConnectMessage().withClientIdentifier(username);
      clientDetails!.connectionMessage = connMessage;

      try {
        // clientDetails!.autoReconnect = true;
        clientDetails!.keepAlivePeriod = 60;
        await clientDetails!.connect(username, pass);

        await subscribeToTopicsAndListenMethod();
      } on NoConnectionException catch (e) {
        print(e);
        clientDetails!.disconnect();
        print("disc");
      } on SocketException catch (e) {
        print('EXAMPLE::socket exception - $e');
        clientDetails!.disconnect();
      }
    } catch (error) {
      print(error);
    }
  }

  subscribeToTopicsAndListenMethod() async {
    print("enadru print madunnnnn");
    clientDetails!.subscribe("xvzsWFDZ5N", MqttQos.atLeastOnce);
    var channeldata = await getChannelDetailsMethod("xvzsWFDZ5N");
  }

  subscribeToTopicMethod(channelid) async {
    print("channelidssss:$channelid");
    clientDetails!.subscribe("$channelid", MqttQos.atLeastOnce);
  }

  Future getChannelDetails(channel_id) async {
    print("calling me");
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final uniqueid = await sharedPreferences.getString('device_id');
      print("decodedBodysp:${uniqueid}");
      final userMobileNumber = sharedPreferences.getString('UserMobileNumber');
      var url = Uri.parse(
          'https://bjzrb8a47c.execute-api.ap-south-1.amazonaws.com/production/getchanneldetails');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'XlbJLSIbFn8A3yEi4bcNX5oWbuDp2H9x8a7IxVA0',
          },
          body: json.encode(
              {"client_id": "$uniqueid", "channel_id": "${channel_id}"}));
      print("response.bodyresponse.body${response.body}");
      if (json.decode(response.body)['status'] == 'success') {
        return json.decode(response.body)['response']['channel_details'];
      } else {
        return 'NOT_APPLICABLE';
      }
    } catch (error) {
      return 'NOT_APPLICABLE';
    }
  }

  Future getChannelDetailsMethod(channelid) async {
    print("calling me");
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final uniqueid = await sharedPreferences.getString('device_id');
      print("decodedBodysp:${uniqueid}");
      final userMobileNumber = sharedPreferences.getString('UserMobileNumber');
      var url = Uri.parse(
          'https://bjzrb8a47c.execute-api.ap-south-1.amazonaws.com/production/getchanneldetails');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'XlbJLSIbFn8A3yEi4bcNX5oWbuDp2H9x8a7IxVA0',
          },
          body: json
              .encode({"client_id": "$uniqueid", "channel_id": "$channelid"}));
      print("response.bodyresponse.body${response.body}");
      if (json.decode(response.body)['status'] == 'success') {
        return json.decode(response.body)['response']['channel_details'];
      } else {
        return 'NOT_APPLICABLE';
      }
    } catch (error) {
      return 'NOT_APPLICABLE';
    }
  }

  MQTTSubscribeMethod(channelid) async {
    try {
      print("subscribed$channelid");
      Future.delayed(Duration(seconds: 2));
      print(
          "channeldcbcatssaMQTTSubscribeMethod${clientDetails!.connectionStatus}");
      var abc =
          await clientDetails!.subscribe("$channelid", MqttQos.atLeastOnce);
      print("printing something:$abc");
      Future.delayed(Duration(seconds: 2));
      var resp = await getChannelDetails("$channelid");
      print("resppponsseee$resp");
      print(
          "channeldcbcatssaMQTTSubscribeMethod${resp["total_number_of_subscribers"]}name${resp["channel_name"]}");

      return 'SUCCESS';
    } catch (error) {
      print("channeldcbcatssajoining error:${error.toString()}");
      return 'FAILURE';
    }
  }

  Future unsubscribeToChannel(channel_id) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final uniqueid = await sharedPreferences.getString('device_id');

      var url = Uri.parse(
          'https://bjzrb8a47c.execute-api.ap-south-1.amazonaws.com/production/unsubscribechannel');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'XlbJLSIbFn8A3yEi4bcNX5oWbuDp2H9x8a7IxVA0',
          },
          body: json.encode({
            "client_id": "$uniqueid",
            "channel_id": channel_id,
          }));

      if (json.decode(response.body)['status'] == 'success') {
        print("subscribe:::unsubscibed");
        return 'SUCCESS';
      } else {
        return 'FAILURE';
      }
    } catch (e) {
      return 'FAILURE';
    }
  }

  MQTTDisconnectMethod() {
    try {
      if (clientDetails != null) {
        clientDetails?.disconnect();
        return 'SUCCESS';
      } else {
        return 'FAILURE';
      }
    } catch (error) {
      print(error);
      return 'FAILURE';
    }
  }

  static void pong() {
    print('Ping response client callback invoked');
  }

  onAutoReconnect() async {
    listenerObject?.cancel();
    print("MQTT is Reconnecting !!!");
    // MqttConnectFlags()

    setSharedPrefrerences('CONNECTED');
  }

  onConnected() {
    print("*********************************************************");
    print("MQTT is Getting Connected !!!");
    listenToMessages();

    setSharedPrefrerences('CONNECTED');
  }

  onDisconnected() async {
    print("&&&&&&&& Got Disconnected &&&&&&&&&");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var connectionDetail =
        await jsonDecode("${sharedPreferences.getString('allconnectionData')}");
    if (isDataConnected == true) {
      await MQTTConnections().connectToMQTTMethod(
          connectionDetail['ip_address'],
          connectionDetail['port'],
          connectionDetail['user_name'],
          connectionDetail['password']);
      print('CONNECTED');
    } else {
      await MQTTConnections().connectToMQTTMethod(
          connectionDetail['ip_address'],
          connectionDetail['port'],
          connectionDetail['user_name'],
          connectionDetail['password']);
      print('CONNECTED');
    }
  }

  onSubscribed(topic) {
    print("&&&&&&&&&&SubScribed&&&&&&&&&&&&&");
    print("*****");
  }

  onSubscribeFail(topic) {
    print("*Failed To Subscribed!!!*");
  }

  getConnetctionStatus() {
    var status = clientDetails!.connectionStatus!.state;
    return status;
  }

  Future pushDataToHive(hiveChannelList, messageItem) async {
    try {
      var channelObject = await channel?.get(messageItem['channel_id']);
      log("channelDetails:$channelObject");
      await channel!.put(channelObject['channel_id'], channelObject);
    } catch (error) {
      print(error);
    }
  }

  listenToMessages() async {
    print("******Listener Got Initiated********");
    var channelObject = await channel?.get('xvzsWFDZ5N');
    log("channelDetails:$channelObject");

    listenerObject = clientDetails!.updates
        ?.listen((List<MqttReceivedMessage<MqttMessage>> event) async {
      print("**Iam Listening**");

      var receivedMessage = event[0].payload as MqttPublishMessage;
      final messageItem = json.decode(
        MqttPublishPayload.bytesToStringAsString(
            receivedMessage.payload.message),
      );

      if (receivedMessage.payload.message.isEmpty) return;
      messageItem['channel_message'] = utf8.decode(
          (messageItem["channel_message"] as String)
              .replaceAll(RegExp("[^0-9,]"), "")
              .replaceAll(" ", "")
              .split(",")
              .map((string) => int.parse(string))
              .toList());
      log("listentomsgggggg${jsonDecode(messageItem['channel_message'])}");
      if (messageItem != null) {
        if (messageItem["channel_id"] == "xvzsWFDZ5N") {
          await allmessages!.put("allmessages", messageItem);
          log("allresponsehimsssve${allmessages!.get("allmessages")}");
        } else {
          var subscribe = jsonDecode(messageItem['channel_message']);
          print("subscribe:::1$subscribe");
          if (subscribe["message_type"] != null) {
            print(
                "subscribe:::2    ${subscribe["channel_id"]}  idOfChannel    $idOfChannel    ${subscribe["channel_id"].toString().trim() == idOfChannel.trim()}");
            if (subscribe["channel_id"].toString().trim() ==
                idOfChannel.trim()) {
              if (subscribe["message_type"] == "INCREASED_SUBSCRIPTION") {
                subcount.value = subscribe["total_number_of_subscribers"];
                print("subscribe:::3$subcount");
              } else if (subscribe["message_type"] ==
                  "DECREASED_SUBSCRIPTION") {
                if (subscribe["channel_id"].toString().trim() ==
                    idOfChannel.trim()) {
                  subcount.value = subscribe["total_number_of_subscribers"];
                }
              }
            }
          }
        }
      }

      try {} catch (error) {
        print(error);
      }
    });
  }

  setSharedPrefrerences(connection_status) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("connection_status", connection_status);
  }

  getUserDetails() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return jsonDecode(shared.getString('userDetails')!);
  }

  internalDisconnect() {}
}
