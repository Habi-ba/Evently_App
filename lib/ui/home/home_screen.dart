import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/home/widgets/category_chip.dart';
import 'package:evently/ui/home/widgets/event_card.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../utils/app_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.scaleHeight(24)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: context.scaleFont(13),
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(2)),
                      Text(
                        'John Safwat',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: context.scaleFont(20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // زرار الثيم - UI بس، من غير onTap
                      Container(
                        padding: EdgeInsets.all(context.scaleWidth(8)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: Icon(
                          Icons.wb_sunny_outlined,
                          size: context.scaleFont(18),
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: context.scaleWidth(8)),
                      // بادچ اللغة - UI بس
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scaleWidth(12),
                          vertical: context.scaleHeight(8),
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'EN',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontSize: context.scaleFont(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: context.scaleHeight(20)),

              // ====== الكاتيجوري - "All" ظاهرة مختارة ثابت، الباقي شكل بس ======
              SizedBox(
                height: context.scaleHeight(42),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryChip(
                      label: 'All',
                      icon: Icons.grid_view_rounded,
                      isSelected: true,
                    ),
                    CategoryChip(
                      label: 'Sport',
                      icon: Icons.directions_bike,
                      isSelected: false,
                    ),
                    CategoryChip(
                      label: 'Birthday',
                      icon: Icons.cake_outlined,
                      isSelected: false,
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.scaleHeight(16)),

              // ====== ليستة الـ events - داتا ثابتة ======
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: context.scaleHeight(90)),
                  children: [
                    EventCard(
                      day: '21',
                      month: 'Jan',
                      title: 'Birthday',
                      subtitle: 'This is a Birthday Party',
                      lightImage: AppImages.birthdayLightImage,
                      darkImage: AppImages.birthdayDarkImage,
                      isFavorite: true,
                    ),
                    EventCard(
                      day: '22',
                      month: 'Jan',
                      title: 'Meeting',
                      subtitle: 'Meeting for Updating The Development Method',
                      lightImage: AppImages.meetingLightImage,
                      darkImage: AppImages.meetingDarkImage,
                      isFavorite: false,
                    ),
                    EventCard(
                      day: '23',
                      month: 'Jan',
                      title: 'Exhibition',
                      subtitle: 'Discover unique exhibitions and talents',
                      lightImage: AppImages.exhibitionLightImage,
                      darkImage: AppImages.exhibitionDarkImage,
                      isFavorite: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        onPressed: () {},
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.home),
            label: LocaleKeys.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.heartOutline),
            label: LocaleKeys.favorite.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountOutline),
            label: LocaleKeys.profile.tr(),
          ),
        ],
      ),
    );
  }
}
