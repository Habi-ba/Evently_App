import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/home/event_screens/event_image_helper.dart';
import 'package:evently/utils/ToastUtils.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../../models/event.dart';
import '../../../utils/themed_image.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: context.scaleWidth(343),
      height: 194,
      margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
      padding: EdgeInsets.fromLTRB(
        context.scaleWidth(8),
        context.scaleHeight(8),
        context.scaleWidth(12),
        context.scaleHeight(10),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            child: ThemedImage(
              lightImage: EventImageHelper.lightImageFor(
                  event.eventCategoryIndex),
              darkImage: EventImageHelper.darkImageFor(
                  event.eventCategoryIndex),
              width: context.scaleWidth(343),
              height: context.scaleHeight(193),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Text(
                  DateFormat('dd MMMM').format(event.eventDate),
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: context.scaleHeight(2)),
              Spacer(),

              Container(
                height: 50,
                padding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(16),
                  vertical: context.scaleHeight(14),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        event.eventTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: context.scaleWidth(8)),
                    IconButton(

                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: context.scaleFont(26),
                      icon: Icon(
                        event.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      color:
                      event.isFavourite
                          ? theme.colorScheme.primary
                          : theme.iconTheme.color,
                      onPressed: () {
                        FirebaseUtils.updateIsFavourite(event).
                        then((value) {
                          return ToastUtils.
                          showToastMessage(
                              message: LocaleKeys.event_updated_successfully
                                  .tr(),
                              backgroundColor: Colors.green,
                              textColor: AppColors.whiteColor);
                        },).catchError((error) {
                          return ToastUtils.
                          showToastMessage(
                              message: error.toString(),
                              backgroundColor: Colors.red,
                              textColor: AppColors.whiteColor);
                        },);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}