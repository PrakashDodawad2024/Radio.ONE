// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../utils/constant.dart';

class Texts extends StatefulWidget {
  final String text;
  final double size;

  const Texts({
    Key? key,
    required this.text,
    required this.size,
  }) : super(key: key);

  @override
  State<Texts> createState() => _TextsState();
}

class _TextsState extends State<Texts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: widget.size,
            color: isDark == true ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
