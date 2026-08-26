import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/app-theme_provider.dart';
import 'package:evently/ui/home/widgets/tab_item_widget.dart';
import 'package:evently/ui/login/widgets/elevated_button_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/ToastUtils.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:provider/provider.dart';

import '../event_image_helper.dart';
import 'date_or_time_widget.dart';

class AddEventScreen extends StatefulWidget {
  final Event? existingEvent;

  const AddEventScreen({super.key, this.existingEvent});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  var formKey = GlobalKey<FormState>();
  var selectedIndex = 0;
  var title = '';
  var description = '';
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedDate;
  String formatDate = '';
  TimeOfDay? selectedTime;
  String formatTime = '';
  String selectedEventName = '';
  String selectedEventImage = '';

  bool get isEditing => widget.existingEvent != null;

  List<String> eventNamesList = [
    LocaleKeys.sport.tr(),
    LocaleKeys.exhibition.tr(),
    LocaleKeys.birthday.tr(),
    LocaleKeys.book_club.tr(),
    LocaleKeys.meeting.tr(),
  ];


  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final event = widget.existingEvent!;
      selectedIndex = event.eventCategoryIndex - 1;
      title = event.eventTitle;
      description = event.eventDescription;
      titleController.text = event.eventTitle;
      descriptionController.text = event.eventDescription;
      selectedDate = event.eventDate;
      selectedTime = TimeOfDay.fromDateTime(event.eventDate);
      formatDate = DateFormat('dd/MM/yyyy').format(event.eventDate);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    selectedEventName = eventNamesList[selectedIndex];
    selectedEventImage = themeProvider.isDarkMode
        ? EventImageHelper.darkImageFor(selectedIndex + 1)
        : EventImageHelper.lightImageFor(selectedIndex + 1);

    if (isEditing && selectedTime != null && formatTime.isEmpty) {
      formatTime = selectedTime!.format(context);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            isEditing ? LocaleKeys.edit_event.tr() : LocaleKeys.add_event.tr(),
            style: theme.textTheme.headlineSmall,
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(start: 10, top: 10),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: context.scaleHeight(193),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: AssetImage(selectedEventImage),
                      ),
                      border: Border.all(color: theme.dividerColor),
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  SizedBox(
                    height: context.scaleHeight(40),

                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: TabItemWidget(
                            isSelected: selectedIndex == index,
                            eventName: eventNamesList[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: context.scaleWidth(10));
                      },
                      itemCount: eventNamesList.length,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(10)),
                  Text(
                      LocaleKeys.title.tr(), style: theme.textTheme.bodyMedium),
                  SizedBox(height: context.scaleHeight(8)),
                  TextFieldWidget(
                    hintDisplayedTxt: LocaleKeys.event_title_hint.tr(),
                    controller: titleController,
                    onChanged: (text) {
                      title = text;
                    },
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return LocaleKeys.please_enter_event_title.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: context.scaleHeight(10)),
                  Text(
                    LocaleKeys.description.tr(),
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: context.scaleHeight(8)),
                  TextFieldWidget(
                    hintDisplayedTxt: LocaleKeys.event_description_hint.tr(),
                    controller: descriptionController,
                    lines: 4,
                    onChanged: (text) {
                      description = text;
                    },
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return LocaleKeys.please_enter_event_description.tr();
                      }
                      return null;
                    },
                  ),
                  DateOrTimeWidget(
                    icon: Icon(MdiIcons.calendar, color: theme.iconTheme.color),
                    eventDateOrTime: LocaleKeys.event_date.tr(),
                    onChooseDateOrTime: chooseDate,
                    chooseDateOrTime:
                    selectedDate == null
                        ? LocaleKeys.choose_date.tr()
                        : formatDate,
                  ),
                  DateOrTimeWidget(
                    icon: Icon(MdiIcons.clock, color: theme.iconTheme.color),
                    eventDateOrTime: LocaleKeys.event_time.tr(),
                    onChooseDateOrTime: chooseTime,
                    chooseDateOrTime:
                    selectedTime == null
                        ? LocaleKeys.choose_time.tr()
                        : formatTime,
                  ),
                  SizedBox(height: context.scaleHeight(15)),
                  ElevatedButtonWidget(
                    onTab: isEditing ? updateEvent : addEvent,
                    buttonText: isEditing
                        ? LocaleKeys.update_event.tr()
                        : LocaleKeys.add_event.tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState!.validate() == true) {
      if (selectedTime == null || selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.please_choose_date_time.tr())),
        );
        return;
      }
      Event event = Event(
        eventCategoryIndex: selectedIndex + 1,
        eventName: selectedEventName,
        eventDate: DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ),
        eventDescription: description,
        eventImage: selectedEventImage,
        eventTitle: title,
      );
      DialogUtils.showLoading(
          context: context, loadingText: LocaleKeys.loading.tr());
      FirebaseUtils.addEventToFireStore(event)
          .then((value) {
        DialogUtils.hideLoading(context: context);
        ToastUtils.showToastMessage(
            message: LocaleKeys.event_Add_successfully.tr(),
            backgroundColor: Colors.greenAccent,
            textColor: Theme
                .of(context)
                .primaryColor);
        Navigator.pop(context);
      })
          .catchError((error) {
        DialogUtils.hideLoading(context: context);
        ToastUtils.showToastMessage(
            message: error.toString(),
            backgroundColor: Colors.red,
            textColor: Theme
                .of(context)
                .colorScheme
                .onPrimary);
      });
    }
  }

  void updateEvent() {
    if (formKey.currentState!.validate() == true) {
      if (selectedTime == null || selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.please_choose_date_time.tr())),
        );
        return;
      }
      Event updatedEvent = widget.existingEvent!.copyWith(
        eventCategoryIndex: selectedIndex + 1,
        eventName: selectedEventName,
        eventDate: DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ),
        eventDescription: description,
        eventImage: selectedEventImage,
        eventTitle: title,
      );
      DialogUtils.showLoading(
          context: context, loadingText: LocaleKeys.loading.tr());
      FirebaseUtils.updateEvent(updatedEvent)
          .then((value) {
        DialogUtils.hideLoading(context: context);
        ToastUtils.showToastMessage(
            message: LocaleKeys.event_updated_successfully.tr(),
            backgroundColor: Colors.greenAccent,
            textColor: Theme
                .of(context)
                .primaryColor);
        Navigator.pop(context);
      })
          .catchError((error) {
        DialogUtils.hideLoading(context: context);
        ToastUtils.showToastMessage(
            message: error.toString(),
            backgroundColor: Colors.red,
            textColor: Theme
                .of(context)
                .colorScheme
                .onPrimary);
      });
    }
  }

  Future<void> chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chooseDate != null) {
      selectedDate = chooseDate;
      formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      setState(() {});
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (chooseTime != null) {
      selectedTime = chooseTime;
      formatTime = selectedTime!.format(context);
      setState(() {});
    }
  }
}