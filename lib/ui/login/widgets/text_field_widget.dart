import 'package:evently/utils/colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final Icon? sufIcon;
  final Icon prefIcon;
  final String hintDisplayedTxt;

  const TextFieldWidget({
    super.key,
    this.sufIcon,
    required this.hintDisplayedTxt,
    required this.prefIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: context.scaleHeight(12),
          horizontal: context.scaleWidth(16),
        ),
        hintText: hintDisplayedTxt,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        prefixIcon: prefIcon,
        suffixIcon: sufIcon,
        enabledBorder: _OutlineBorderBulider(
          context,
          Theme.of(context).colorScheme.outline,
        ),
        focusedBorder: _OutlineBorderBulider(
          context,
          Theme.of(context).colorScheme.outline,
        ),
        errorBorder: _OutlineBorderBulider(context, AppColors.redColor),
      ),
    );
  }
}

OutlineInputBorder _OutlineBorderBulider(
  BuildContext context,
  Color colorUsed,
) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: colorUsed),
    gapPadding: 1.5,
  );
}
