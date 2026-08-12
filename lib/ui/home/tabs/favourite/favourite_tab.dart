import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_images.dart';
import '../../widgets/event_card.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextFieldWidget(
                hintDisplayedTxt: LocaleKeys.search_hint.tr(),
                sufIcon: Icon(Icons.search_rounded),
              ),
            ),

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
