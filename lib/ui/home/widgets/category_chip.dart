import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;

  const CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color bgColor =
        isSelected ? theme.colorScheme.primary : theme.colorScheme.surface;
    final Color contentColor =
        isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(16),
        vertical: context.scaleHeight(10),
      ),
      margin: EdgeInsets.only(right: context.scaleWidth(10)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isSelected ? bgColor : theme.dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.scaleFont(18), color: contentColor),
          SizedBox(width: context.scaleWidth(6)),
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: contentColor,
              fontSize: context.scaleFont(14),
            ),
          ),
        ],
      ),
    );
  }
}
