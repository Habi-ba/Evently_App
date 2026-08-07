import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/intro/pages_list.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:evently/utils/themed_image.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late final PageController _pageController;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRoute);
  }

  void _nextPage() {
    if (currentPage == 2) {
      _goToHome();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    if (currentPage == 0) return;

    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = getOnboardingPages(
      context,
      currentPage: currentPage,
      totalPages: 3,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            ///================ HEADER =================
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.scaleWidth(16),
                vertical: context.scaleHeight(12),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child:
                        currentPage == 0
                            ? const SizedBox()
                            : IconButton(
                              onPressed: _previousPage,
                              icon: const Icon(Icons.arrow_back_ios_new),
                            ),
                  ),

                  Expanded(
                    child: Center(
                      child: ThemedImage(
                        lightImage: AppImages.eventlyLogoLightImage,
                        darkImage: AppImages.eventlyLogoDarkImage,
                        width: context.scaleWidth(142),
                        height: context.scaleHeight(30),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 63,
                    height: 32,
                    child:
                        currentPage == 2
                            ? const SizedBox()
                            : Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                              child: TextButton(
                                onPressed: _goToHome,
                                child: Text(
                                  "skip".tr(),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                  ),
                ],
              ),
            ),

            ///================ PAGE VIEW =================
            Expanded(
              child: PageView.builder(
                controller: _pageController,

                itemCount: pages.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (_, index) => pages[index],
              ),
            ),

            ///================ FOOTER =================
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.scaleWidth(16),
                0,
                context.scaleWidth(16),
                context.scaleHeight(16),
              ),
              child: SizedBox(
                width: double.infinity,
                height: context.scaleHeight(56),

                child: ElevatedButton(
                  onPressed: _nextPage,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: Text(
                    currentPage == 2 ? "get_started".tr() : "next".tr(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
