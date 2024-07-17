// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../utils/constant.dart';

class DisplayImage extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  const DisplayImage({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(blurRadius: 1),
          ],
          //   shape: const BeveledRectangleBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          //   side: BorderSide(color: Colors.black, width: 4),
          // ),
          //color: Colors.yellow,
          borderRadius: BorderRadius.circular(10)),
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: status != 'Offline'
            ? FadeInImage(
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/Raydeo.ONE512.png',
                  );
                },
                placeholder:
                    const AssetImage("assets/images/Raydeo.ONE512.png"),
                image: NetworkImage("${widget.url}"),
                fit: BoxFit.fill,
              )
            : const Image(image: AssetImage("assets/images/Raydeo.ONE512.png")),
      ),
    );
  }
}
