import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../../../models/event.dart';
import '../../widgets/event_card.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  Stream<List<Event>>? favouriteStream;
  List<Event> favouriteList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteStream = FirebaseUtils.getAllFavouriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextFieldWidget(
                hintDisplayedTxt: LocaleKeys.search_hint.tr(),
                sufIcon: Icon(Icons.search_rounded),
              ),
            ),

            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: favouriteStream,
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
                    favouriteList = snapshot.data!;

                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: context.scaleHeight(90)),
                      itemBuilder: (BuildContext context, int index) {
                        return EventCard(event: favouriteList[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: context.scaleHeight(10));
                      },
                      itemCount: favouriteList.length,
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
