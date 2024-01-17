import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialData {
  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  static const KScaffoldBackGroundColor = Color(0xffF0F3F4);

  //custom category
  final Color pinkColor = Color(0xF8CD265A);
  final Color blackColor = Color(0xff1B222F);
  final Color whiteColor = Color(0xFFE5E8E8);
  final Color blueColor = Color(0xE90974C8);

////////Dark Theme
  ThemeData darkThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.red[800],
    cardColor: Color(0xff1B222F),
    // fontFamily: 'Akaya',
    // backgroundColor:Color(0xff1B222F) ,
    scaffoldBackgroundColor: Color(0xff1B222F),
    primaryColorDark: Color(0xff1B222F),
    canvasColor: Color(0xff1B222F),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red[800],
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.red[900],
    ),
    shadowColor: Color(0xff1B222F),

    colorScheme: ColorScheme.dark(),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.white,
    ),
  );

////////Light Theme

  ThemeData lightThemData = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.indigo,
      primarySwatch: Colors.indigo,
      hoverColor: Colors.deepPurple,
      primaryColorLight: Colors.indigo,
      splashColor: Colors.indigo,
      buttonColor: Colors.indigo,
      hintColor: Colors.indigo,
      canvasColor: Color(0xffF0F3F4),
      scaffoldBackgroundColor: Color(0xffF0F3F4),
      backgroundColor: Color(0xffF0F3F4),
      cardColor: Color(0xffEBF5F5),
      shadowColor: Colors.black38,
      highlightColor: Colors.white10,
      // fontFamily: 'Akaya',
      /* bottomNavigationBarTheme: BottomNavigationBarThemeData(
        // selectedItemColor: Colors.black12,
        selectedItemColor: Colors.black,
      ),*/
      /*  appBarTheme: AppBarTheme(
        backgroundColor: Color(0xffF0F3F4),

        // color: Color(0xF8CD265A),
        brightness: Brightness.light,
      ),*/
      colorScheme: ColorScheme.light(),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.purple.shade100,
        cursorColor: Colors.purple.shade100,
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(color: Colors.black),
      ));

/*  List<TextEditingController> controllersList=[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];*/
}
