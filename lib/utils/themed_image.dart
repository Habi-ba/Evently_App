import 'package:evently/providers/app-theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemedImage extends StatelessWidget {
  final String lightImage;
  final String darkImage;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const ThemedImage({
    super.key,
    required this.lightImage,
    required this.darkImage,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, _) {
        return Image.asset(
          themeProvider.isDarkMode ? darkImage : lightImage,
          height: height,
          width: width,
          fit: fit,
        );
      },
    );
  }
}
