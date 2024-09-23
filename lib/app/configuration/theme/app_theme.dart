import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {

  final bool isDarkMode;

  AppTheme({ required this.isDarkMode });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.kPrimaryGreen1,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,

    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.kPrimaryGreen1,
    ),
  );

}