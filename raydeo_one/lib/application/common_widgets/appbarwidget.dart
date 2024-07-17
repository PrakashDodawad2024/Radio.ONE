import 'package:flutter/material.dart';
import '../landingpages/search.dart';
import '../profilepages/profile.dart';
import '../../utils/constant.dart';

Widget AppBarWidget(context, setState) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).backgroundColor,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('  '),
        IconButton(
          onPressed: () {
            showSearch(
                context: context,
                delegate: CustomSearchDelegate(setState: setState));
          },
          icon: Icon(
            Icons.search,
            color: maincolor,
            size: 28,
          ),
        ),
      ],
    ),
    title: Text(
      'Radio.ONE',
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    centerTitle: true,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Profile(),
              ));
            },
            icon: Icon(
              Icons.account_circle_rounded,
              color: maincolor,
              size: 40,
            ),
          ),
          const Text('    ')
        ],
      ),
    ],
  );
}
