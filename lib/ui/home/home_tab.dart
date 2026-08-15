import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/home/widgets/event_card.dart';
import 'package:evently/ui/home/widgets/tab_item_widget.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/locale_keys.g.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_images.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var userProvider = Provider.of<UserProvider>(context);
    List<String> eventNamesList = [
      LocaleKeys.all.tr(),
      LocaleKeys.sport.tr(),
      LocaleKeys.birthday.tr(),
      LocaleKeys.book_club.tr(),
      LocaleKeys.exhibition.tr(),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
      child: DefaultTabController(
        length: eventNamesList.length,
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
                      userProvider.currentUser!.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: context.scaleFont(20),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
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

            SizedBox(
              height: context.scaleHeight(42),
              child: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(8),
                ),
                tabAlignment: TabAlignment.start,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },

                tabs:
                    eventNamesList.map((eventName) {
                      return TabItemWidget(
                        isSelected:
                            selectedIndex == eventNamesList.indexOf(eventName),
                        eventName: eventName,
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: context.scaleHeight(16)),

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
    );
  }
}
