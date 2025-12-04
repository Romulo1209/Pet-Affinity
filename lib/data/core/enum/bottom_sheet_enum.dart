import 'package:flutter/material.dart';

enum BottomSheetEnum {
  home("Home", null, "assets/icons/home.svg"),
  map("Map", null, "assets/icons/map.svg"),
  create("Create", null, "assets/icons/plus.svg"),
  chat("Chat", null, "assets/icons/chat.svg"),
  profile("Profile", null, "assets/icons/profile.svg");

  final String type;
  final IconData? iconData;
  final String? svgPath;

  const BottomSheetEnum(this.type, this.iconData, this.svgPath);
}
