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
  DateTime eventDate;
  bool isFavourite;

  //todo:attributes
  Event({
    this.eventId = '',
    required this.eventName,
    required this.eventDate,
    required this.eventDescription,
    required this.eventImage,
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
        eventId: json['even_id'],
      );

  //object =>json
  Map<String, dynamic> toJson() {
    return {
      'even_id': eventId,
      'event_image': eventImage,
      'event_name': eventName,
      'event_title': eventTitle,
      'event_description': eventDescription,
      'is_favourite': isFavourite,
      'event_date': eventDate,
    };
  }
}
