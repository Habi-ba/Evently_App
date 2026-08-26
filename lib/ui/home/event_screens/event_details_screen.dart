import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/models/event.dart';
import 'package:evently/utils/ToastUtils.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:provider/provider.dart';

import '../../../providers/app-theme_provider.dart';
import 'add_event/add_event_screen.dart';
import 'event_image_helper.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
      stream: FirebaseUtils.getEventStream(event.eventId),
      initialData: event,
      builder: (context, snapshot) {
        final currentEvent = snapshot.data ?? event;
        return _EventDetailsBody(event: currentEvent);
      },
    );
  }
}

class _EventDetailsBody extends StatelessWidget {
  final Event event;

  const _EventDetailsBody({required this.event});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    final eventImage =
        themeProvider.isDarkMode
            ? EventImageHelper.darkImageFor(event.eventCategoryIndex)
            : EventImageHelper.lightImageFor(event.eventCategoryIndex);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          LocaleKeys.event_details.tr(),
          style: theme.textTheme.headlineSmall,
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsetsDirectional.only(start: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
              color: theme.colorScheme.surface,
            ),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: theme.primaryColor,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEventScreen(existingEvent: event),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 8, top: 10),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.colorScheme.outline),
                color: theme.colorScheme.surface,
              ),
              child: Icon(Icons.edit_outlined, color: theme.primaryColor),
            ),
          ),
          InkWell(
            onTap: () => _confirmDelete(context),
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 10, top: 10),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.colorScheme.outline),
                color: theme.colorScheme.surface,
              ),
              child: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.scaleHeight(193),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: AssetImage(eventImage),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: theme.dividerColor),
                ),
              ),
              SizedBox(height: context.scaleHeight(16)),

              Text(event.eventTitle, style: theme.textTheme.headlineSmall),
              SizedBox(height: context.scaleHeight(12)),

              Container(
                height: context.scaleHeight(80),
                padding: const EdgeInsets.all(12),
                // margin:const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.outline),
                  color: theme.colorScheme.surface,
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: context.scaleHeight(44),
                          width: context.scaleWidth(44),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.colorScheme.outline,
                            ),
                            color: theme.scaffoldBackgroundColor,
                          ),
                        ),
                        Positioned(
                          left: 9,
                          top: 9,
                          bottom: 9,
                          right: 9,
                          child: Icon(
                            MdiIcons.calendar,
                            color: theme.primaryColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: context.scaleWidth(16)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM').format(event.eventDate),
                          style: theme.textTheme.displayLarge,
                        ),

                        SizedBox(height: context.scaleHeight(5)),
                        Text(
                          DateFormat('h:mm a').format(event.eventDate),
                          style: theme.textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.scaleHeight(16)),

              Text(
                LocaleKeys.description.tr(),
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: context.scaleHeight(8)),
              Container(
                height: context.scaleHeight(179),
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.outline),
                  color: theme.colorScheme.surface,
                ),
                child: Text(
                  event.eventDescription,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    DialogUtils.showMessage(
      context: context,
      title: LocaleKeys.delete_event.tr(),
      message: LocaleKeys.confirm_delete_event.tr(),
      posActionName: LocaleKeys.delete.tr(),
      posAction: () => _deleteEvent(context),
      negActionName: LocaleKeys.cancel.tr(),
    );
  }

  void _deleteEvent(BuildContext context) {
    DialogUtils.showLoading(
      context: context,
      loadingText: LocaleKeys.loading.tr(),
    );
    FirebaseUtils.deleteEvent(event)
        .then((_) {
          DialogUtils.hideLoading(context: context);
          Navigator.pop(context); // close details screen
          ToastUtils.showToastMessage(
            message: LocaleKeys.event_deleted_successfully.tr(),
            backgroundColor: Colors.green,
            textColor: Theme.of(context).colorScheme.onPrimary,
          );
        })
        .catchError((error) {
          DialogUtils.hideLoading(context: context);
          ToastUtils.showToastMessage(
            message: error.toString(),
            backgroundColor: Colors.red,
            textColor: Theme.of(context).colorScheme.onPrimary,
          );
        });
  }
}
