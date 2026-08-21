import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/login/widgets/elevated_button_widget.dart';
import 'package:evently/ui/login/widgets/outlined_button_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/locale_keys.g.dart';
import '../../utils/themed_image.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'habiba');

  var emailController = TextEditingController(text: 'habibafd2@gmail.com');

  var passwordController = TextEditingController(text: '122323');

  var confirmPasswordController = TextEditingController(text: '122323');

  var formKey = GlobalKey<FormState>();

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
                  child: Form(
                    key: formKey,
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
                            controller: nameController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return LocaleKeys.please_enter_name.tr();
                              }
                              return null;
                            },
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
                            controller: emailController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return LocaleKeys.please_enter_email.tr();
                              }
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(text.trim())) {
                                return LocaleKeys.please_enter_valid_email.tr();
                              }
                              return null;
                            },
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
                            controller: passwordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return LocaleKeys.please_enter_password.tr();
                              }
                              if (text.length < 6) {
                                return LocaleKeys.password_min_length.tr();
                              }
                              return null;
                            },
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
                            controller: confirmPasswordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return LocaleKeys.please_enter_confirm_password
                                    .tr();
                              }
                              if (text != passwordController.text) {
                                return LocaleKeys.passwords_do_not_match.tr();
                              }
                              return null;
                            },
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
                            onTab: onSignUp,
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
              ),
            );
          },
        ),
      ),
    );
  }

  void onSignUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      DialogUtils.showLoading(
        context: context,
        loadingText: LocaleKeys.waiting.tr(),
      );

      // 1. Firebase Auth
      final credential = await FirebaseUtils.registerWithEmail(
        email: emailController.text,
        password: passwordController.text,
      );

      // 2. Create MyUser
      MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        name: nameController.text,
        email: emailController.text,
      );

      // 3. Update Provider
      var userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      userProvider.updateUser(myUser);

      // 4. Save in Firestore
      await FirebaseUtils.addUserInFireStore(myUser);

      // 5. Hide loading
      DialogUtils.hideLoading(context: context);

      // 6. Show success
      DialogUtils.showMessage(
        posActionName: LocaleKeys.ok.tr(),
        title: LocaleKeys.success.tr(),
        context: context,
        message: LocaleKeys.registered_successfully.tr(),
        posAction: () {
          Navigator.of(context).pushNamed(
            AppRoutes.homeScreenRoute,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context: context);

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = LocaleKeys.email_already_registered.tr();
          break;

        case 'weak-password':
          message = LocaleKeys.weak_password.tr();
          break;

        case 'invalid-email':
          message = LocaleKeys.invalid_email.tr();
          break;

        case 'operation-not-allowed':
          message = LocaleKeys.registration_disabled.tr();
          break;

        default:
          message = LocaleKeys.something_went_wrong.tr();
      }

      DialogUtils.showMessage(
        posActionName: LocaleKeys.ok.tr(),
        title: LocaleKeys.error.tr(),
        context: context,
        message: message,
      );
    }
  }

  void onTab2() async {
    try {
      DialogUtils.showLoading(
          context: context, loadingText: LocaleKeys.waiting.tr());

      final credential = await FirebaseUtils.signInWithGoogle();

      MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        name: credential.user?.displayName ?? '',
        email: credential.user?.email ?? '',
      );

      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(myUser);

      await FirebaseUtils.addUserInFireStore(myUser);

      DialogUtils.hideLoading(context: context);

      DialogUtils.showMessage(
        posActionName: LocaleKeys.ok.tr(),
        title: LocaleKeys.success.tr(),
        context: context,
        message: LocaleKeys.registered_successfully.tr(),
        posAction: () {
          Navigator.of(context).pushNamed(AppRoutes.homeScreenRoute);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
        posActionName: LocaleKeys.ok.tr(),
        title: LocaleKeys.error.tr(),
        context: context,
        message: e.message ?? LocaleKeys.something_went_wrong.tr(),
        );
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          posActionName: LocaleKeys.ok.tr(),
          title: LocaleKeys.error.tr(),
          context: context,
          message: e.toString(),
        );
      }
    }
  }

