import 'package:flutter/material.dart';

const textColor = Color(0xFF05cdff);
const backgroundColor = Color(0xFFf9fcf8);
const primaryColor = Color(0xFF38d7ff);
const primaryFgColor = Color(0xFFf9fcf8);
const secondaryColor = Color(0xFFa6dceb);
const secondaryFgColor = Color(0xFFf9fcf8);
const accentColor = Color(0xFF38d7ff);
const accentFgColor = Color(0xFFf9fcf8);

const defaultScheme = ColorScheme(
  brightness: Brightness.light,
  background: backgroundColor,
  onBackground: textColor,
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
