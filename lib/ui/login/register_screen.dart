import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/login/widgets/elevated_button_widget.dart';
import 'package:evently/ui/login/widgets/outlined_button_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    if (formKey.currentState!.validate() == true) {
      // todo: register logic
      try {
        //todo:1-show Loading

        DialogUtils.showLoading(context: context, loadingText: 'Waiting...');
        //todo:2-fireAuth
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        //todo:3-save user provider
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text
        );
        //listen:fales => 34an e7na bra el build
        //m3nah enna m4 3ayzen n3rf haga lama el user yt8yer
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        //todo:hideLoading
        DialogUtils.hideLoading(context: context);
        //todo:show error
        DialogUtils.showMessage(
          posActionName: 'Ok',
          title: 'Success',
          context: context,
          message: 'Registered Successfully ',
          posAction: () {
            Navigator.of(context).pushNamed(AppRoutes.loginScreenRoute);
          },
        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context: context);
        String message;
        switch (e.code) {
          case 'email-already-in-use':
            message = 'This email is already registered.';
            break;
          case 'weak-password':
            message = 'The password provided is too weak.';
            break;
          case 'invalid-email':
            message = 'Invalid email address.';
            break;
          case 'operation-not-allowed':
            message = 'Registration is currently disabled.';
            break;
          default:
            message = e.message ?? 'Something went wrong.';
        }
        DialogUtils.showMessage(
          posActionName: 'Ok',
          title: 'Error',
          context: context,
          message: message,
        );
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          posActionName: 'Ok',
          title: 'Error',
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  void onTab2() {}
}
