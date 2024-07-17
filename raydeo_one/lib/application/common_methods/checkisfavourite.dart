import '../../main.dart';
import '../../utils/constant.dart';

checkIsFavourite(setState) {
  if (displayfavlist.isNotEmpty) {
    for (int i = 0; i < displayfavlist.length; i++) {
      if (displayfavlist[i]["channel_id"].toString().contains(idOfChannel)) {
        setState(() {
          addFavourite = true;
        });
        break;
      } else {
        setState(() {
          addFavourite = false;
        });
      }
    }
  }
}
