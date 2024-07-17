import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../utils/constant.dart';

class NoFavourites extends StatefulWidget {
  const NoFavourites({super.key});

  @override
  State<NoFavourites> createState() => _NoFavouritesState();
}

class _NoFavouritesState extends State<NoFavourites> {
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).backgroundColor,
      height: screensize.height * 0.22,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_rounded,
              color: maincolor,
              size: 45,
            ),
            Text(
              "Your favourite channels will appear here",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
