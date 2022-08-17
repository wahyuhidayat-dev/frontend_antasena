import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

//! Color
Color orange = Color.fromARGB(255, 248, 120, 84);
Color yellow = Color.fromARGB(255, 248, 234, 84);
Color green = Color.fromARGB(255, 84, 248, 103);
Color blue = Color.fromARGB(255, 84, 191, 248);
Color black = Colors.black;
Color white = Colors.white;
Color greyy = Color(0xFF8D92A3);
Color whitee = Color(0xFFFAFAFC);

const Color grey = Color.fromARGB(255, 118, 128, 130);

//! Font style
TextStyle fontRegular = GoogleFonts.poppins(fontWeight: FontWeight.w400);
TextStyle fontMedium = GoogleFonts.poppins(fontWeight: FontWeight.w600);
TextStyle fontBold = GoogleFonts.poppins(fontWeight: FontWeight.bold);

var logo = "assets/images/antasena.png";
var ic_home = "assets/images/ic_home.png";
var ic_home_normal = "assets/images/ic_home_normal.png";
var ic_order = "assets/images/ic_order";
var ic_order_normal = "assets/images/ic_home_normal";
var ic_profile = "assets/images/ic_profile";
var ic_profile_normal = "assets/images/ic_profile_normal.png";

double defaultMargin = 24;

var base_url = "http://10.0.2.2:8000";

var loadingIndicator = SpinKitFoldingCube(
  color: orange,
  size: 50,
);
