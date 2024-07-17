import '../landingpages/homepage.dart';
import '../../main.dart';
import '../../utils/constant.dart';

setRadioPlayer(
  setState,
) async {
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
}
