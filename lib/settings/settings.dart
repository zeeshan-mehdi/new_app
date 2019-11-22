

import 'package:flutter/cupertino.dart';
// Agora AppId
import 'dart:ui';

const APP_ID = "fd0d0d32bab44de5b0135b99cfbd50db";

class Constants {
  var gray = const Color(0xfff9f9f9);
}

class Menu{
  static const String settings = 'Profile';
  static const String signOut= 'SignOut';


  static const List<String> choices =<String> [settings,signOut];

}



class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}