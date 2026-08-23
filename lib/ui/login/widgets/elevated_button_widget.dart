import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onTab;
  final String buttonText;

  const ElevatedButtonWidget({
    super.key,
    required this.onTab,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTab,

        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).cardColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
