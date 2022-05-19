import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rally2plus/controls/globals.dart';

const kWhite = Color(0xFFEEEEEE);
const kDarkGrey = Color(0xFF4a4a4a);
const kRed = Color(0xFFc70000);
const kDPurple = Color(0xFF200122);
const kDRed = Color(0xFF6f0000);
const kLLightGrey = Color(0xFFdddddd);
const kLightGrey = Color(0xFFbbbbbb);
const kBlack = Color(0xFF171717);
const kBlue = Color(0xFF1a2a6c);
const kSRed = Color(0xFFb21f1f);
const kYellow = Color(0xFFfdbb2d);

List<IconData> getBottomNavBarIcons() {
  List<IconData> listaIcone = [];
  for (int i = 0; i < kBottomNavBarName.length; i++) {
    listaIcone.add(kBottomNavBarIcons[i]);
  }
  return listaIcone;
}

const kBottomNavBarIcons = [
  Icons.home_outlined,
  Icons.star_border_outlined,
  Icons.api_outlined,
];
