import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static LinearGradient transparentGradient =  LinearGradient(colors: [const Color(0xffE8E8E8).withOpacity(0.6),const Color(0xffFFFFFF).withOpacity(0.42)]);
  static LinearGradient farmStayAppBar = const LinearGradient(colors: [Color(0xffFFB802),Color(0xffFFDA93)]);
  static LinearGradient blueGradient = LinearGradient(colors: [
    const Color(0xff6FBABF),
    const Color(0xff233539).withOpacity(0.76)
  ]);

  static LinearGradient titleBackgroundGradient = const LinearGradient(
    colors: [Color(0xffDFC94F), Color(0xffFFEE93)],
  );

  static LinearGradient detailedBackgroundGradient = LinearGradient(colors: [
    const Color(0xffFAE367),
    const Color(0xffCDB740).withOpacity(0.8)
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static LinearGradient detailedBackgroundGradient2 = LinearGradient(colors: [
    const Color(0xffFAE367),
    const Color(0xffFAE367),
    const Color(0xffe7cf47).withOpacity(0.8),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);


  ThemeData themeData() {
    return ThemeData(
        scaffoldBackgroundColor:Colors.black,
        primarySwatch: Colors.yellow,
        primaryColor: const Color(0xffFFE13A),
        primaryColorLight: const Color(0xffFFE13A),
        accentColor: const Color(0xffDFC94F),
        backgroundColor: const Color(0xff1C4F14),
        textTheme: TextTheme(
            bodyText2: GoogleFonts.mavenPro(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            bodyText1: GoogleFonts.fruktur(
                fontSize: 25, color: const Color(0xff00410A)),
            headline1: GoogleFonts.mavenPro(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 4),
                    blurRadius: 4,
                  )
                ]),
            headline2: GoogleFonts.mavenPro(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            headline3: GoogleFonts.mavenPro(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
            headline4: GoogleFonts.mavenPro(
                fontSize: 18,
                color: const Color(0xff31562B),
                fontWeight: FontWeight.bold),
          headline5: GoogleFonts.mavenPro(
              fontSize: 24,
              color: const Color(0xff00410A),
              fontWeight: FontWeight.bold),
          headline6: GoogleFonts.mavenPro(
              fontSize: 14,
              color: const Color(0xff7E7E7E),
              fontWeight: FontWeight.bold),
          caption: GoogleFonts.mavenPro(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,),
          subtitle1: GoogleFonts.mavenPro(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,),


        ));
  }
}
