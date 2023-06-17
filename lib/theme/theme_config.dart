import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(BuildContext context) => ThemeData(
      scaffoldBackgroundColor: AppColor.scaffoldBackground,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColor.primaryColor),
      appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: AppColor.appBarBackgroundColor,
          iconTheme: const IconThemeData(color: AppColor.appBarPrimaryIconColor),
          titleTextStyle: GoogleFonts.montserrat(),
          titleSpacing: 6,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xFF000000),
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: null,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          )),
      brightness: Brightness.light,
      // textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
      textTheme: GoogleFonts.montserratTextTheme().apply(),
    );

class AppColor {
  static const Color appBarBackgroundColor = Colors.white;
  static const Color appBarPrimaryIconColor = Colors.black;
  static const Color appBarSecondaryIconColor = Colors.black38;
  static Color scaffoldBackground = const Color(0xffF8F7FF);
  static const Color primaryColor = Color(0xff5E56E7);
  static const Color lightGrey = Color(0xffF0F0F6);
  static const Color grey = Color(0xffA0A0A0);
  static const Color darkGrey = Color(0xff333333);

}