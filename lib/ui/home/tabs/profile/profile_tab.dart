import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/providers/app-theme_provider.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_images.dart';
import '../../../../utils/colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(20)),
          child: Column(
            children: [
              SizedBox(height: context.scaleHeight(24)),

              // ====== الأفاتار (لوجو التطبيق داخل دايرة) ======
              CircleAvatar(
                backgroundImage: AssetImage(AppImages.routeLogoImage),
                radius: 50,
              ),

              SizedBox(height: context.scaleHeight(14)),

              Text(
                'John Safwat',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: context.scaleFont(18),
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),

              Text(
                'johnsafwat.route@gmail.com',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: context.scaleFont(13),
                ),
              ),

              SizedBox(height: context.scaleHeight(28)),

              // ====== Dark mode row ======
              _ProfileTile(
                title: LocaleKeys.dark_mode.tr(),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                  activeColor: theme.colorScheme.primary,
                ),
                onTap: () {},
              ),

              SizedBox(height: context.scaleHeight(10)),

              // ====== Language row ======
              _ProfileTile(
                title: LocaleKeys.language.tr(),
                trailing: Icon(
                  Icons.chevron_right,
                  color: theme.iconTheme.color,
                ),
                onTap: () {
                  if (context.locale.languageCode == 'ar') {
                    context.setLocale(Locale('en'));
                  } else if (context.locale.languageCode == 'en') {
                    context.setLocale(Locale('ar'));
                  }
                },
              ),

              SizedBox(height: context.scaleHeight(10)),

              // ====== Logout row ======
              _ProfileTile(
                title: LocaleKeys.logout.tr(),
                trailing: const Icon(
                  Icons.logout_outlined,
                  color: AppColors.redColor,
                ),
                onTap: () {
                  // TODO: نفذي عملية تسجيل الخروج
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        onPressed: () {},
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
      ),
    );
  }
}

// ====== ويدجت مساعدة لصف واحد في البروفايل (تايتل + عنصر على اليمين) ======
class _ProfileTile extends StatelessWidget {
  final String title;

  final Widget trailing;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.title,

    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(16),
          vertical: context.scaleHeight(14),
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: context.scaleFont(15),
              ),
            ),
            SizedBox(width: 36, height: 24, child: trailing),
          ],
        ),
      ),
    );
  }
}
