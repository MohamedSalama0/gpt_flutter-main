import 'package:flutter/material.dart';
import 'package:gpt_flutter/constants/app_styles.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ThemeData
  .light(useMaterial3: true).colorScheme
  .copyWith(
        primary: Colors.white,
        onPrimary: AppStyles.darkColor,
        secondary: AppStyles.secondSuggestionBoxColor,
        onSecondary: Colors.white,
      ),
);

final darkTheme = ThemeData
.dark(useMaterial3: true)
.copyWith(
  colorScheme: ThemeData.dark(useMaterial3: true).colorScheme.copyWith(
        primary: AppStyles.darkColor,
        onPrimary: Colors.white,
        secondary: const Color(0xffE3BD49),
        onSecondary: Colors.white,
      ),
);