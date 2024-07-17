import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/constant.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: maincolor,
    backgroundColor: Colors.white,
    accentColor: Colors.grey.shade800,
    cardColor: Colors.white,
    canvasColor: Colors.white70,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: maincolor.withOpacity(0.5))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: maincolor.withOpacity(0.5))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: maincolor.withOpacity(0.5))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          // backgroundColor:
          //     MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 0, 139)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.transparent)))),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
      selectedItemColor: maincolor,
      unselectedItemColor: Colors.grey.shade600,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
        indicatorColor: maincolor,
        indicatorSize: TabBarIndicatorSize.tab,
        // indicator: BoxDecoration(
        //     color: Colors.white,
        //     // borderRadius: BorderRadius.circular(10),
        //     border: Border(
        //         bottom: BorderSide(
        //       width: 2,
        //       color: Color.fromARGB(255, 0, 0, 139),
        //     ))),
        indicator: ShapeDecoration(
            color: maincolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        // dividerColor: Colors.red,
        // overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
        unselectedLabelColor: Colors.grey.shade700,
        labelColor: Colors.white)
    // popupMenuTheme: PopupMenuThemeData(
    //   color:
    // )
    // textTheme: TextTheme(
    //     titleLarge:
    //         TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
    );

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: maincolor,
    accentColor: Colors.white,
    backgroundColor: Colors.grey.shade900,
    cardColor: Colors.grey.shade700,
    canvasColor: Colors.grey.shade700,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade700,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: maincolor.withOpacity(0.5))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: maincolor.withOpacity(0.5))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: maincolor.withOpacity(0.5))),
    ),
    // buttonColor: Color.fromARGB(255, 0, 0, 139),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(maincolor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.transparent)))),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.grey.shade900,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey.shade600,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.grey.shade900,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: maincolor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      // BoxDecoration(
      //     color: Colors.white,
      //     border: Border(
      //         bottom: BorderSide(
      //       width: 2,
      //       color: Color.fromARGB(255, 0, 0, 139),
      //     ))),
      // dividerColor: Colors.red,
      // overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
      unselectedLabelColor: Colors.white54,
      labelColor: maincolor,
    )

    // textTheme: TextTheme(
    //     titleLarge: TextStyle(
    //         color: Colors.grey.shade800, fontWeight: FontWeight.normal)),
    );

// textTheme.titleMedium --> button text
//textTheme.headlineSmall--> headline
//textTheme.labelLarge--> label
//textTheme.headlinesmall --> appbar title
//
///
////
/////
//////
// import 'package:flutter/material.dart';

// Color lightThemePrimary = Color.fromARGB(255, 70, 28, 4);
// Color darkThemePrimary = Color.fromARGB(255, 209, 147, 84);
// Color secondaryColor = Color.fromARGB(255, 251, 234, 217);

// ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   primaryColor: lightThemePrimary,
//   backgroundColor: secondaryColor,
//   accentColor: Colors.grey.shade800,
//   iconButtonTheme: IconButtonThemeData(
//       style: ButtonStyle(
//           iconColor: MaterialStateProperty.all<Color>(
//               lightThemePrimary.withOpacity(0.5)))),
//   cardColor: lightThemePrimary.withOpacity(0.5),
//   canvasColor: Colors.white70,
//   dividerColor: Colors.grey.shade300,
//   iconTheme: IconThemeData(color: Colors.grey.shade800, size: 26),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     hintStyle: TextStyle(fontSize: 16),
//     fillColor: darkThemePrimary.withOpacity(0.2),
//     contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     floatingLabelStyle: TextStyle(color: lightThemePrimary),
//     border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Colors.transparent)),
//     enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Colors.transparent)),
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Colors.transparent)),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(lightThemePrimary),
//         shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//             side: BorderSide(color: Colors.transparent)))),
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     elevation: 0,
//     backgroundColor: secondaryColor,
//     selectedItemColor: lightThemePrimary,
//     unselectedItemColor: Colors.grey.shade600,
//     showSelectedLabels: true,
//     showUnselectedLabels: true,
//     type: BottomNavigationBarType.fixed,
//   ),
//   appBarTheme: AppBarTheme(
//       color: secondaryColor,
//       elevation: 0,
//       actionsIconTheme: IconThemeData(color: lightThemePrimary, size: 30),
//       iconTheme: IconThemeData(color: lightThemePrimary, size: 24)),
//   tabBarTheme: TabBarTheme(
//       indicatorColor: lightThemePrimary,
//       indicatorSize: TabBarIndicatorSize.tab,
//       indicator: ShapeDecoration(
//           color: lightThemePrimary,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
//       unselectedLabelColor: Colors.grey.shade700,
//       labelColor: Colors.white),
//   switchTheme: SwitchThemeData(
//     trackColor: MaterialStateProperty.all<Color>(
//       Colors.grey.shade500,
//     ),
//     thumbColor: MaterialStateProperty.all<Color>(
//       lightThemePrimary,
//     ),
//   ),
//   dialogBackgroundColor: secondaryColor,
//   popupMenuTheme: PopupMenuThemeData(color: secondaryColor),
//   textTheme: TextTheme(
//       //elevated button text color
//       button: TextStyle(
//           fontSize: 18, color: secondaryColor, fontWeight: FontWeight.normal),
//       //textButton text theme
//       subtitle1: TextStyle(
//           fontSize: 18,
//           color: lightThemePrimary,
//           fontWeight: FontWeight.normal),

//       //contents
//       subtitle2: TextStyle(
//           fontSize: 14,
//           color: Colors.grey.shade700,
//           fontWeight: FontWeight.w400),
//       //onboarding headers
//       headline1: TextStyle(
//           fontSize: 24,
//           color: Colors.grey.shade800,
//           fontWeight: FontWeight.w600),
//       //headlinesmall for appbar title
//       //directory_name
//       headline2: TextStyle(
//           color: Colors.grey.shade800,
//           fontSize: 16,
//           fontWeight: FontWeight.w400),
//       //directory_sub
//       headline3: TextStyle(
//         fontSize: 12,
//         color: Colors.grey.shade700,
//       ),
//       //entry details lablel
//       headline4: TextStyle(
//           fontSize: 14,
//           color: Colors.grey.shade700,
//           fontWeight: FontWeight.w400),
//       //entry details value
//       headline6: TextStyle(
//           fontSize: 14,
//           color: Colors.grey.shade700,
//           fontWeight: FontWeight.w500),
//       //underlined text
//       caption: TextStyle(
//           fontSize: 14,
//           color: lightThemePrimary,
//           fontWeight: FontWeight.w400,
//           decoration: TextDecoration.underline)),
// );

// ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: darkThemePrimary,
//   backgroundColor: Colors.grey.shade900,
//   accentColor: Colors.white,
//   iconButtonTheme: IconButtonThemeData(
//       style: ButtonStyle(
//           iconColor: MaterialStateProperty.all<Color>(
//               darkThemePrimary.withOpacity(0.5)))),
//   cardColor: darkThemePrimary.withOpacity(0.2),
//   // cardColor: Colors.grey.shade800,
//   canvasColor: Colors.grey.shade600,
//   dividerColor: secondaryColor.withOpacity(0.3),
//   iconTheme: IconThemeData(color: Colors.grey.shade500),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     hintStyle: TextStyle(fontSize: 16),
//     fillColor: darkThemePrimary.withOpacity(0.2),
//     contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     floatingLabelStyle: TextStyle(color: darkThemePrimary),
//     border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Colors.transparent)),
//     enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Colors.transparent)),
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: BorderSide(color: Colors.transparent)),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(darkThemePrimary),
//         shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//             side: BorderSide(color: Colors.transparent)))),
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     elevation: 0,
//     backgroundColor: Colors.grey.shade900,
//     selectedItemColor: darkThemePrimary,
//     unselectedItemColor: Colors.grey.shade600,
//     showSelectedLabels: true,
//     showUnselectedLabels: true,
//     type: BottomNavigationBarType.fixed,
//   ),
//   appBarTheme: AppBarTheme(
//       actionsIconTheme: IconThemeData(color: darkThemePrimary, size: 30),
//       color: Colors.grey.shade900,
//       elevation: 0,
//       iconTheme: IconThemeData(color: darkThemePrimary, size: 24)),
//   tabBarTheme: TabBarTheme(
//       indicatorColor: darkThemePrimary,
//       indicatorSize: TabBarIndicatorSize.tab,
//       indicator: ShapeDecoration(
//           color: darkThemePrimary,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
//       unselectedLabelColor: Colors.white54,
//       labelColor: secondaryColor),
//   switchTheme: SwitchThemeData(
//     trackColor: MaterialStateProperty.all<Color>(
//       Colors.grey.shade500,
//     ),
//     thumbColor: MaterialStateProperty.all<Color>(
//       darkThemePrimary,
//     ),
//   ),
//   textTheme: TextTheme(
//       //elevated button text color
//       button: TextStyle(
//           fontSize: 18, color: secondaryColor, fontWeight: FontWeight.normal),
//       //textButton text theme
//       subtitle1: TextStyle(
//           fontSize: 18, color: darkThemePrimary, fontWeight: FontWeight.normal),

//       //contents
//       subtitle2: TextStyle(
//           fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w400),
//       //onboarding headers
//       headline1: TextStyle(
//           fontSize: 24, color: Colors.white70, fontWeight: FontWeight.w600),
//       //headlinesmall for appbar title
//       //directory_name
//       headline2: TextStyle(
//           color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w400),
//       //directory_sub
//       headline3: TextStyle(
//         fontSize: 12,
//         color: Colors.white54,
//       ),
//       //entry details lablel
//       headline4: TextStyle(
//           fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w400),
//       //entry details value
//       headline6: TextStyle(
//           fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w500),
//       //underlined text
//       caption: TextStyle(
//           fontSize: 14,
//           color: darkThemePrimary,
//           fontWeight: FontWeight.w400,
//           decoration: TextDecoration.underline)),
// );

// textTheme.titleMedium --> button text
//textTheme.headlineSmall--> headline
//textTheme.labelLarge--> label
//textTheme.headlinesmall --> appbar title
//titleLarge--> listviewbuilder title
//bodylarge-->expansionwidgetcontnet and title