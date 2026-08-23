import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/themed_image.dart';
import 'package:flutter/material.dart';

import 'onboarding_page.dart';

class OnboardingPageData {
  final Widget image;
  final String title;
  final String body;

  const OnboardingPageData({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<Widget> getOnboardingPages(
  BuildContext context, {
  required int currentPage,
  required int totalPages,
}) {
  final pages = <OnboardingPageData>[
    OnboardingPageData(
      image: ThemedImage(
        lightImage: AppImages.onboarding2LightImage,
        darkImage: AppImages.onboarding2DarkImage,
        fit: BoxFit.contain,
      ),
      title: "onboarding_title_1".tr(),
      body: "onboarding_desc_1".tr(),
    ),

    OnboardingPageData(
      image: ThemedImage(
        lightImage: AppImages.onboarding3LightImage,
        darkImage: AppImages.onboarding3DarkImage,
        fit: BoxFit.contain,
      ),
      title: "onboarding_title_2".tr(),
      body: "onboarding_desc_2".tr(),
    ),

    OnboardingPageData(
      image: ThemedImage(
        lightImage: AppImages.onboarding4LightImage,
        darkImage: AppImages.onboarding4DarkImage,
        fit: BoxFit.contain,
      ),
      title: "onboarding_title_3".tr(),
      body: "onboarding_desc_3".tr(),
    ),
  ];

  return List.generate(
    pages.length,
    (index) => OnboardingPage(
      page: pages[index],
      currentPage: currentPage,
      totalPages: totalPages,
    ),
  );
}
