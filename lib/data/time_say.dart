import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeCall extends StatelessWidget {
  String text = "";
  int timeNow = DateTime.now().hour;

  TimeCall({Key? key}) : super(key: key);
  String callTime() {
    if (timeNow <= 11) {
      text = "Good Morning  ☀️";
    }
    if (timeNow > 11) {
      text = "Good Afternoon  🌞";
    } if (timeNow >= 16){
      text = "Good Evening  🌆";
    } if (timeNow >= 18) {
      text = "Good Night  🌙";
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      callTime(),
      style: GoogleFonts.lato(
    fontWeight: FontWeight.bold,
    fontSize: 27,
      ),
    );
  }
}
