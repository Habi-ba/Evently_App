import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface, // ← خلفية الـ toggle نفسه (مش المختار)
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          _toggleOption(
            context,
            label: 'english'.tr(),
            selected: !isArabic,
            onTap: () => context.setLocale(const Locale('en')),
          ),
          _toggleOption(
            context,
            label: 'arabic'.tr(),
            selected: isArabic,
            onTap: () => context.setLocale(const Locale('ar')),
          ),
        ],
      ),
    );
  }

  Widget _toggleOption(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class ThemeToggle extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const ThemeToggle({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          _iconOption(
            context: context,
            icon: Icons.wb_sunny,
            selected: !isDarkMode,
            onTap: () => onChanged(false),
          ),
          _iconOption(
            context: context,
            icon: Icons.nightlight_round,
            selected: isDarkMode,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }

  Widget _iconOption({
    required BuildContext context,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          size: 16,
          color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
        ),
      ),
    );
  }
}
