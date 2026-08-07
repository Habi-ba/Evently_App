import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app-theme_provider.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/intro/introduction_screen.dart';
import 'package:evently/ui/intro/pages_list.dart';
import 'package:evently/ui/intro/personalize_screen.dart';
import 'package:evently/ui/login/login_screen.dart';
import 'package:evently/ui/login/register_screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('ar'),
      child: ChangeNotifierProvider(
        create: (context) => AppThemeProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: 'home_screen',
      routes: {
        AppRoutes.homeScreenRoute: (context) => HomeScreen(),
        AppRoutes.introScreenRoute: (context) => IntroScreen(),
        AppRoutes.personalizeScreenRoute: (context) => PersonalizeScreen(),
        AppRoutes.loginScreenRoute: (context) => LoginScreen(),
        AppRoutes.registerScreenRoute: (context) => RegisterScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppThemeProvider().themeMode,
    );
  }
}
