import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Widget? prefixIcon;

  const OutlinedButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(10)),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            SizedBox(
              width: 50,
              child:
                  prefixIcon == null
                      ? const SizedBox()
                      : Center(child: prefixIcon),
            ),

            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 36),
          ],
        ),
      ),
    );
  }
}
