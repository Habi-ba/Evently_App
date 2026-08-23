import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

import '../utils/app_images.dart';

class EventCategoryData {
  final String id;
  final String label;
  final IconData icon;
  final String lightImage;
  final String darkImage;

  const EventCategoryData({
    required this.id,
    required this.label,
    required this.icon,
    required this.lightImage,
    required this.darkImage,
  });
}

class EventCategories {
  static List<EventCategoryData> all = [
    EventCategoryData(
      id: 'Book club',
      label: 'Book club',
      icon: MdiIcons.bookOutline,
      lightImage: AppImages.bookClubLightImage,
      darkImage: AppImages.bookClubDarkImage,
    ),
    EventCategoryData(
      id: 'Sport',
      label: 'Sport',
      icon: MdiIcons.bike,
      lightImage: AppImages.sportLightImage,
      darkImage: AppImages.sportDarkImage,
    ),
    EventCategoryData(
      id: 'Birthday',
      label: 'Birthday',
      icon: MdiIcons.cakeVariantOutline,
      lightImage: AppImages.birthdayLightImage,
      darkImage: AppImages.birthdayDarkImage,
    ),
  ];

  static EventCategoryData byId(String id) {
    return all.firstWhere((c) => c.id == id, orElse: () => all.first);
  }
}
