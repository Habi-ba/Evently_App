import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/login/widgets/elevated_button_widget.dart';
import 'package:evently/ui/login/widgets/outlined_button_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../generated/locale_keys.g.dart';
import '../../utils/themed_image.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scaleWidth(16),
                    vertical: context.scaleHeight(31),
                  ),
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
                      SizedBox(height: 47),
                      Text(
                        LocaleKeys.signup_title.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: TextFieldWidget(
                          hintDisplayedTxt: LocaleKeys.name_hint.tr(),
                          prefIcon: Icon(
                            MdiIcons.accountOutline,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: TextFieldWidget(
                          hintDisplayedTxt: LocaleKeys.email_hint.tr(),
                          prefIcon: Icon(
                            MdiIcons.emailOutline,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
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
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: TextFieldWidget(
                          hintDisplayedTxt:
                              LocaleKeys.confirm_password_hint.tr(),
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
                      SizedBox(height: 45),
                      Center(
                        child: ElevatedButtonWidget(
                          onTab: onTab1,
                          buttonText: LocaleKeys.sign_up.tr(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            LocaleKeys.already_have_account.tr(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.loginScreenRoute,
                              );
                            },
                            child: Text(
                              LocaleKeys.login.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
                      OutlinedButtonWidget(
                        onTap: onTab2,
                        text: LocaleKeys.signup_with_google.tr(),
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
            );
          },
        ),
      ),
    );
  }
}

void onTab1() {}

void onTab2() {}
