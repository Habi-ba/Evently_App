import 'package:evently/utils/app_images.dart';

/// Maps an event's `eventCategoryIndex` to its light/dark image asset.
///

class EventImageHelper {
  static const List<String> lightImages = [
    AppImages.sportLightImage,
    AppImages.exhibitionLightImage,
    AppImages.birthdayLightImage,
    AppImages.bookClubLightImage,
    AppImages.meetingLightImage,
  ];

  static const List<String> darkImages = [
    AppImages.sportDarkImage,
    AppImages.exhibitionDarkImage,
    AppImages.birthdayDarkImage,
    AppImages.bookClubDarkImage,
    AppImages.meetingDarkImage,
  ];

  static String lightImageFor(int eventCategoryIndex) {
    return lightImages[eventCategoryIndex - 1];
  }

  static String darkImageFor(int eventCategoryIndex) {
    return darkImages[eventCategoryIndex - 1];
  }
}
