import 'package:evently/ui/intro/pages_list.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData page;
  final int currentPage;
  final int totalPages;

  const OnboardingPage({
    super.key,
    required this.page,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 6, child: Center(child: page.image)),

          _OnboardingDots(currentPage: currentPage, totalPages: totalPages),

          SizedBox(height: context.scaleHeight(28)),

          Text(page.title, style: Theme.of(context).textTheme.titleLarge),

          SizedBox(height: context.scaleHeight(16)),

          Text(page.body, style: Theme.of(context).textTheme.labelSmall),

          const Spacer(),
        ],
      ),
    );
  }
}

class _OnboardingDots extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _OnboardingDots({required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        bool active = index == currentPage;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: context.scaleHeight(8),
          width: active ? context.scaleWidth(22) : context.scaleWidth(8),
          decoration: BoxDecoration(
            color:
                active
                    ? Theme.of(context).primaryColor
                    : AppColors.lightGrayColor,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}
