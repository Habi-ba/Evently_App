import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_styles.dart';
import '../../../utils/themed_image.dart';

class EventCard extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String subtitle;
  final String lightImage;
  final String darkImage;
  final bool isFavorite;

  const EventCard({
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    required this.lightImage,
    required this.darkImage,
    required this.isFavorite,
  });

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
              lightImage: lightImage,
              darkImage: darkImage,
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
                  '$day $month',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: context.scaleHeight(2)),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: context.scaleFont(13),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: context.scaleWidth(8)),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: context.scaleFont(20),
                        color:
                            isFavorite
                                ? theme.colorScheme.primary
                                : theme.iconTheme.color,
                      ),
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
