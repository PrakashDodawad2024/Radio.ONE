import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../application/landingpages/homepage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      splashIconSize: 300,
      splash: Center(
        child: Column(
          children: [
            Container(
                color: const Color.fromARGB(255, 50, 50, 50),
                padding: const EdgeInsets.all(15),
                width: 300,
                height: 300,
                child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image(
                        image: AssetImage("assets/icons/Raydeo.ONE.png")))),
          ],
        ),
      ),
      duration: 300,
      nextScreen: const MyHomePage(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
