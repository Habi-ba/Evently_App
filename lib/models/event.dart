import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  //todo:collection
  static const String collectionName = 'Events';

  //todo:attributes
  String eventId;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  int eventCategoryIndex;
  DateTime eventDate;
  bool isFavourite;

  //todo:attributes
  Event({
    this.eventId = '',
    required this.eventName,
    required this.eventDate,
    required this.eventDescription,
    required this.eventImage,
    required this.eventCategoryIndex,
    required this.eventTitle,
    this.isFavourite = false,
  });

  //json=>object
  Event.fromJson(Map<String, dynamic> json)
    : this(
        eventDate: (json['event_date'] as Timestamp).toDate(),
        eventDescription: json['event_description'],
        eventImage: json['event_image'],
        eventName: json['event_name'],
        eventTitle: json['event_title'],
      eventId: json['event_id'],
      isFavourite: json['is_favourite'],
      eventCategoryIndex: json['event_category_index']
      );

  //object =>json
  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_image': eventImage,
      'event_name': eventName,
      'event_title': eventTitle,
      'event_description': eventDescription,
      'is_favourite': isFavourite,
      'event_date': eventDate,
      'event_category_index': eventCategoryIndex
    };
  }

  Event copyWith({
    String? eventId,
    String? eventImage,
    String? eventName,
    String? eventTitle,
    String? eventDescription,
    int? eventCategoryIndex,
    DateTime? eventDate,
    bool? isFavourite,
  }) {
    return Event(
      eventId: eventId ?? this.eventId,
      eventImage: eventImage ?? this.eventImage,
      eventName: eventName ?? this.eventName,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      eventCategoryIndex: eventCategoryIndex ?? this.eventCategoryIndex,
      eventDate: eventDate ?? this.eventDate,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
