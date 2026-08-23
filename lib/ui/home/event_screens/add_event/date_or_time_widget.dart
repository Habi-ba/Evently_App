import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  const DateOrTimeWidget({
    super.key,
    required this.icon,
    required this.eventDateOrTime,
    required this.onChooseDateOrTime,
    required this.chooseDateOrTime,
  });

  final Widget icon;
  final String eventDateOrTime;
  final String chooseDateOrTime;
  final VoidCallback onChooseDateOrTime;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        icon,
        SizedBox(width: context.scaleWidth(8)),
        Text(eventDateOrTime, style: theme.textTheme.bodyMedium),
        Spacer(),
        TextButton(
          onPressed: onChooseDateOrTime,
          child: Text(chooseDateOrTime, style: theme.textTheme.displaySmall),
        ),
      ],
    );
  }
}
