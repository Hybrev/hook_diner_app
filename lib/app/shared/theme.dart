import 'package:flutter/material.dart';

const textColor = Color(0xFF0088c2);
const backgroundColor = Color(0xFFfffcfa);
const primaryColor = Color(0xFF48bef4);
const primaryFgColor = Color(0xFFfffcfa);
const secondaryColor = Color(0xFFc5eafc);
const secondaryFgColor = Color(0xFFfffcfa);
const accentColor = Color(0xFF73cdf7);
const accentFgColor = Color(0xFFfffcfa);

const defaultScheme = ColorScheme(
  brightness: Brightness.light,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: Brightness.light == Brightness.light
      ? Color(0xffB3261E)
      : Color(0xffF2B8B5),
  onError: Brightness.light == Brightness.light
      ? Color(0xffFFFFFF)
      : Color(0xff601410),
);
