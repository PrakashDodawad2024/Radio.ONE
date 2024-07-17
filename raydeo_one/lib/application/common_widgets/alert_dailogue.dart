import 'package:flutter/material.dart';
import '../../utils/constant.dart';

Widget alertDialog(context) {
  return AlertDialog(
    title: Row(
      children: const [
        Text("Exit "),
        Icon(Icons.exit_to_app_rounded),
      ],
    ),
    content: Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Do you want to exit?",
            // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    print('yes selected');
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: maincolor),
                  child: const Text("Yes"),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  print('no selected');
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                ),
                child: const Text("No", style: TextStyle(color: Colors.black)),
              ))
            ],
          )
        ],
      ),
    ),
  );
}
