import 'package:flutter/material.dart';

class SizeConfig {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  static double scaleWidth(BuildContext context, double figmaSize) {
    return (figmaSize / figmaWidth) * width(context);
  }

  static double scaleHeight(BuildContext context, double figmaSize) {
    return (figmaSize / figmaHeight) * height(context);
  }

  static double scaleFont(BuildContext context, double figmaSize) {
    double scaleFactor = width(context) / figmaWidth;
    return figmaSize * scaleFactor;
  }
}

extension ScreenUtils on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double scaleWidth(double figmaSize) => SizeConfig.scaleWidth(this, figmaSize);

  double scaleHeight(double figmaSize) =>
      SizeConfig.scaleHeight(this, figmaSize);

  double scaleFont(double figmaSize) => SizeConfig.scaleFont(this, figmaSize);
}
