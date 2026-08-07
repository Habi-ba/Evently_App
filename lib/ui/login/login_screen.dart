import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/login/widgets/elevated_button_widget.dart';
import 'package:evently/ui/login/widgets/outlined_button_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:evently/utils/themed_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(17),
            vertical: context.scaleHeight(32),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ThemedImage(
                    lightImage: AppImages.eventlyLogoLightImage,
                    darkImage: AppImages.eventlyLogoDarkImage,
                    width: context.scaleWidth(142),
                    height: context.scaleHeight(30),
                  ),
                ),
                SizedBox(height: context.scaleHeight(48)),
                Text(
                  LocaleKeys.login_title.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: context.scaleHeight(24)),
                SizedBox(
                  width: double.infinity,
                  height: context.scaleHeight(48),
                  child: TextFieldWidget(
                    hintDisplayedTxt: LocaleKeys.email_hint.tr(),
                    prefIcon: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                SizedBox(height: context.scaleHeight(16)),
                SizedBox(
                  width: double.infinity,
                  height: context.scaleHeight(48),
                  child: TextFieldWidget(
                    hintDisplayedTxt: LocaleKeys.password_hint.tr(),
                    prefIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    sufIcon: Icon(
                      MdiIcons.eyeOffOutline,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                SizedBox(height: context.scaleHeight(8)),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      LocaleKeys.forget_password_question.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                SizedBox(height: context.scaleHeight(48)),
                Center(
                  child: ElevatedButtonWidget(
                    onTab: onTab1,
                    buttonText: LocaleKeys.login,
                  ),
                ),
                SizedBox(height: context.scaleHeight(48)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      LocaleKeys.no_account.tr(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.registerScreenRoute,
                        );
                      },
                      child: Text(
                        LocaleKeys.sign_up.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.scaleHeight(32)),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 2,
                        height: 2,
                        thickness: 1,
                        color: Theme.of(context).colorScheme.outline,
                        indent: 2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        LocaleKeys.or.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 2,
                        height: 2,
                        thickness: 1,
                        color: Theme.of(context).colorScheme.outline,
                        indent: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.scaleHeight(32)),
                OutlinedButtonWidget(
                  onTap: onTab2,
                  text: LocaleKeys.login_with_google.tr(),
                  prefixIcon: SvgPicture.asset(
                    AppImages.googleLogoImage,
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTab1() {}
}

void onTab2() {}
