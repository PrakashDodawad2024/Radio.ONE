import 'package:flutter/material.dart';
import '../../utils/constant.dart';
import '../../main.dart';

snackbar(context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(5),
      shape: const StadiumBorder(),
      backgroundColor: maincolor,
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: Image(image: AssetImage("assets/images/Raydeo.ONE512.png")),
          ),
          SizedBox(
            width: 250,
            child: Text(
              "Please check your internet connection and try again",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        ],
      ),
    ),
  );
}
