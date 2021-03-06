import 'dart:core';

import 'package:flutter/material.dart';

import '../js/color_utils.dart';
import '../index.dart';

class ThemeColor {
  static get disable => Color(0xFFC4C4C4);
  static get active => Color(0xFF3399FF);
  static get black => Color(0x010101);
  static get red => Color(0xFFFFC4F32);
  static get white => Color(0xFFFFFFFF);
  static get background => Color(0xFFEEEFF3);
  static get line => Color(0xFFD9D9D9);
  static get border => Color(0xFFD9D9D9);
  static double addFont = 6.w;
}

TextStyle font(double value, {bool bold = false, FontWeight? weight, color = "#666666", colorA, height, lineThrough = false, letterSpacing = false}) {
  if (ThemeColor.addFont > 0) value = value + ThemeColor.addFont;
  return TextStyle(
    fontWeight: weight ?? (bold ? FontWeight.bold : FontWeight.normal),
    fontSize: value.w,
    color: colorA ?? (color != null ? HexToColor(color) : null),
    decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    letterSpacing: letterSpacing ? -1 : 0,
    height: height,
  );
}
