import 'package:evently/utils/colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

typedef OnChanged = void Function(String)?;
typedef OnValidator = String ?Function(String?)?;

class TextFieldWidget extends StatelessWidget {
  final Icon? sufIcon;
  final Icon? prefIcon;
  final String hintDisplayedTxt;
  final int? lines;
  final TextEditingController? controller;
  final OnChanged onChanged;
  final OnValidator validator;



  const TextFieldWidget({
    super.key,
    this.sufIcon,
    required this.hintDisplayedTxt,
    this.prefIcon,
    this.lines,
    this.onChanged,
    this.controller,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      maxLines: lines ?? 1,
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
          focusedErrorBorder: _OutlineBorderBulider(
              context, AppColors.redColor),
          errorStyle: TextStyle(color: AppColors.redColor)

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
