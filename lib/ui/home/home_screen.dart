// home_screen.dart
// دلوقتي HomeScreen مسؤولة بس عن الـ container: الـ Scaffold + bottomNavigationBar + FAB
// وبتعرض الـ tab المناسبة حسب selectedIndex

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/home/home_tab.dart';
import 'package:evently/ui/home/tabs/favourite/favourite_tab.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;


  final List<Widget> _pages = const [
    HomeTab(),
    FavouriteTab(),
    ProfileTab(),
  ];


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEventScreenRoute);
        },
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.home),
            label: LocaleKeys.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.heartOutline),
            label: LocaleKeys.favorite.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountOutline),
            label: LocaleKeys.profile.tr(),
          ),
        ],
      ),
    );
  }
}