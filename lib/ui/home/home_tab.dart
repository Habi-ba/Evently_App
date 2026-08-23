import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/ui/home/widgets/event_card.dart';
import 'package:evently/ui/home/widgets/tab_item_widget.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/locale_keys.g.dart';
import '../../providers/user_provider.dart';
import 'event_screens/event_details_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<Event> eventList = [];
  List<Event> filterEventList = [];

  Stream<List<Event>>? eventStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getAllEvents1();
    eventStream = FirebaseUtils.getAllEvents2();
  }

  void updateStream(int index) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      eventStream = FirebaseUtils.getAllEvents2();
    } else {
      eventStream = FirebaseUtils.getAllFilteredEvents(
        selectedIndex: selectedIndex,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var userProvider = Provider.of<UserProvider>(context);
    var langProvider = Provider.of<AppLanguageProvider>(context);
    List<String> eventNamesList = [
      LocaleKeys.all.tr(),
      LocaleKeys.sport.tr(),
      LocaleKeys.exhibition.tr(),
      LocaleKeys.birthday.tr(),
      LocaleKeys.book_club.tr(),
      LocaleKeys.meeting.tr(),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
      child: DefaultTabController(
        length: eventNamesList.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.scaleHeight(24)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.welcome_back.tr(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: context.scaleFont(13),
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(2)),
                    Text(
                      userProvider.currentUser!.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: context.scaleFont(20),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.scaleWidth(8)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Icon(
                        Icons.wb_sunny_outlined,
                        size: context.scaleFont(18),
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: context.scaleWidth(8)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(12),
                        vertical: context.scaleHeight(8),
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:
                          context.locale.languageCode == 'en'
                              ? Text(
                                'EN',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontSize: context.scaleFont(12),
                                ),
                              )
                              : Text(
                                'ع',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontSize: context.scaleFont(12),
                                ),
                              ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: context.scaleHeight(20)),

            SizedBox(
              height: context.scaleHeight(42),
              child: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(8),
                ),
                tabAlignment: TabAlignment.start,
                onTap: (index) {
                  updateStream(index);
                },

                tabs:
                    eventNamesList.map((eventName) {
                      return TabItemWidget(
                        isSelected:
                            selectedIndex == eventNamesList.indexOf(eventName),
                        eventName: eventName,
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: context.scaleHeight(16)),

            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: eventStream,
                builder: (context, snapshot) {
                  //todo:loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        LocaleKeys.no_events_found_yet.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  } else {
                    eventList = snapshot.data!;

                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: context.scaleHeight(90)),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          // borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EventDetailsScreen(
                                      event: eventList[index],
                                    ),
                              ),
                            );
                          },
                          child: EventCard(event: eventList[index]),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: context.scaleHeight(10));
                      },
                      itemCount: eventList.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
