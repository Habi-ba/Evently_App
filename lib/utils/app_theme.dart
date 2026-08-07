import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.mainLightMode,
      unselectedItemColor: AppColors.disableColor,
      selectedLabelStyle: AppStyles.reg12MainLight,
      unselectedLabelStyle: AppStyles.reg12Disable,
    ),
    cardColor: AppColors.mainLightMode,
    primaryColor: AppColors.mainLightMode,
    dividerColor: AppColors.strokeLightColor,
    iconTheme: IconThemeData(color: AppColors.disableColor),

    colorScheme: ColorScheme.light(
      primary: AppColors.mainLightMode,
      onPrimary: AppColors.whiteColor,
      // لون النص/الأيقونة فوق العنصر المختار
      surface: AppColors.whiteColor,
      // خلفية الـ toggle نفسه (مش الاختيار المحدد)
      onSurface: AppColors.mainLightMode,
      // لون النص/الأيقونة للعنصر الغير مختار
      secondary: AppColors.grayColor,
      outline: AppColors.strokeLightColor,
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyles.semiBold24MainColor,
      headlineMedium: AppStyles.semiBold16MainLight,
      titleLarge: AppStyles.semiBold20Black,
      titleMedium: AppStyles.med18MainColor,
      labelLarge: AppStyles.med20White,
      bodySmall: AppStyles.med14Black,
      labelSmall: AppStyles.reg14Gray,
      bodyMedium: AppStyles.med16Black,
      labelMedium: AppStyles.semiBold14MainColor,
      titleSmall: AppStyles.med16MainColor,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBgColor,
      selectedItemColor: AppColors.mainDarkMode,
      unselectedItemColor: AppColors.disableColor,
      selectedLabelStyle: AppStyles.reg12MainDark,
      unselectedLabelStyle: AppStyles.reg12Disable,
    ),
    cardColor: AppColors.mainDarkMode,
    dividerColor: AppColors.strokeDarkColor,
    iconTheme: IconThemeData(color: AppColors.disableColor),
    primaryColor: AppColors.mainDarkMode,

    colorScheme: ColorScheme.dark(
      primary: AppColors.mainDarkMode,
      onPrimary: AppColors.whiteColor,
      surface: AppColors.darkInputColor,
      // خلفية الـ toggle في الدارك مود
      onSurface: AppColors.whiteColor,
      outline: AppColors.strokeDarkColor,
      secondary: AppColors.lightGrayColor,
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyles.semiBold24White,
      headlineMedium: AppStyles.semiBold16MainDark,
      titleLarge: AppStyles.semiBold20White,
      labelLarge: AppStyles.med20White,
      bodyMedium: AppStyles.med16White,
      titleMedium: AppStyles.med18White,
      bodySmall: AppStyles.med14White,
      labelSmall: AppStyles.reg14LightGray,
      labelMedium: AppStyles.semiBold14MainColorDark,
      titleSmall: AppStyles.med16MainDark,
    ),
  );
}
