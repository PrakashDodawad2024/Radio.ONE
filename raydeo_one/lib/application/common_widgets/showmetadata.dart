import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../utils/constant.dart';

class showMetaData extends StatefulWidget {
  const showMetaData({super.key});

  @override
  State<showMetaData> createState() => _showMetaDataState();
}

class _showMetaDataState extends State<showMetaData> {
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: isDark == true ? Colors.black : Colors.grey.shade300,
      elevation: 0,
      child: SizedBox(
        width: screensize.width * 0.8,
        height: screensize.height * 0.085,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    metadata != null
                        ? metadata![0].isNotEmpty
                            ? metadata![0].contains("errorCode")
                                ? "No Data Found"
                                : metadata![0]
                            : "No Data Found"
                        : "No Data Found",
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: isDark == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: screensize.height * 0.005,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    metadata != null
                        ? metadata![1].isNotEmpty
                            ? metadata![1].contains("errorCode")
                                ? ""
                                : metadata![1]
                            : ""
                        : "",
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: isDark == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            metadata != null ||
                    metadata![1].isNotEmpty ||
                    !metadata![1].contains("errorCode") ||
                    !metadata![0].contains("errorCode")
                ? InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: '${metadata![0]}${metadata![1]}'));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: maincolor,
                          behavior: SnackBarBehavior.floating,
                          shape: StadiumBorder(),
                          duration: const Duration(seconds: 3),
                          content: const Text("Copied Succesfully")));
                    },
                    child: Icon(
                      Icons.copy_outlined,
                      color: maincolor,
                    ))
                : const SizedBox(
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }
}
