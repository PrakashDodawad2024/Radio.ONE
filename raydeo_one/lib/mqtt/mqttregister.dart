import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

import 'mqttconnection.dart';

class Mqtt {
  static RxBool? viewalll = true.obs;
  RxString uniqueId = "".obs;

  registerUserMethod() async {
    print("decodedBodyRegidteruser");

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var deviceid = await deviceInfo.androidInfo.toString();
    AndroidDeviceInfo tvInfo = await deviceInfo.androidInfo;
    log(tvInfo.toString());
    print("decodedBody:${tvInfo.id}");
    print("decodedBody:${tvInfo.device}");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    print(tvInfo.device);
    print('*GETTING QR CODE*');
    try {
      var headers = {
        'Content-Type': 'application/json',
        'x-api-key': 'XlbJLSIbFn8A3yEi4bcNX5oWbuDp2H9x8a7IxVA0'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://bjzrb8a47c.execute-api.ap-south-1.amazonaws.com/production/registerdeviceandgenerateqr'));
      request.body = json.encode({
        if (tvInfo.id != null) "device_id": "", //id has to be empty
        "device_name": "${tvInfo.device}"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final decodedBody = await json.decode(body.toString());
        print(body);
        print("decodedBody111:$decodedBody");
        print(decodedBody['device_id']);
        print(decodedBody['unique_id']);
        print(decodedBody['connection_details']['ip_address']);

        uniqueId.value = decodedBody['unique_id'];

        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('device_id', decodedBody['unique_id']);
        print("spdata:${sharedPreferences.getString('device_id')}");
        print(
            "aconnectionData:${jsonEncode(decodedBody['connection_details'])}");
        sharedPreferences.setBool("isRegistered", true);
        sharedPreferences.setString(
            'allconnectionData', jsonEncode(decodedBody['connection_details']));
        print("spdata:${sharedPreferences.getString('allconnectionData')}");
        await MQTTConnections().connectToMQTTMethod(
            decodedBody['connection_details']['ip_address'],
            decodedBody['connection_details']['port'],
            decodedBody['connection_details']['user_name'],
            decodedBody['connection_details']['password']);
        // websocketSubscribe(decodedBody['device_id'], decodedBody['unique_id']);
        // listAllSubscriptionsOfUser();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }
}
