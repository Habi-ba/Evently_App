import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  TabItemWidget({super.key, required this.isSelected, required this.eventName});

  bool isSelected;
  String eventName;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
        color:
            isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(20),
          vertical: context.scaleHeight(8),
        ),
        child: Text(
          eventName,
          style: isSelected ? AppStyles.med16White : theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
