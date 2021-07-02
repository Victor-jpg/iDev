import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color(0xFFDBE6FD),
          textTheme: TextTheme(
              subtitle1: GoogleFonts.openSans().copyWith(
                fontSize: 16,
                color: Color(0xFFF5A962),
              ),
              subtitle2: TextStyle(color: Colors.black))),
    ).modular();
  }
}
