import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/providers/app-theme_provider.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/themed_image.dart';
import 'toggles.dart';

class PersonalizeScreen extends StatelessWidget {
  const PersonalizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(16),
            vertical: context.scaleHeight(28),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ThemedImage(
                  lightImage: AppImages.eventlyLogoLightImage,
                  darkImage: AppImages.eventlyLogoDarkImage,
                  height: context.scaleHeight(27),
                  width: context.scaleWidth(142),
                ),
              ),
              SizedBox(height: context.scaleHeight(24)),
              ThemedImage(
                lightImage: AppImages.onboarding1LightImage,
                darkImage: AppImages.onboarding1DarkImage,
                height: context.scaleHeight(343),
                width: context.scaleWidth(343),
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              Text(
                LocaleKeys.personalize_title.tr(),
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.personalize_subtitle.tr(),
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 32),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.language.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const LanguageToggle(),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.theme.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Consumer<AppThemeProvider>(
              builder: (context, themeProvider, _) {
                return ThemeToggle(
                  isDarkMode: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.changeTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: context.scaleHeight(48),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.introScreenRoute,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).cardColor,
              padding: const EdgeInsets.symmetric(vertical: 9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text('lets_start'.tr(), style: AppStyles.med20White),
          ),
        ),
      ],
    );
  }
}
