import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/my_user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollections() {
    //ل coverterهي الي بتعرف ال  فايرستور ايه النوع الي بتخزنه
    //snapshot is an instance of a document we should access the data inside it
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore:
              (snapshot, options) => MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static CollectionReference<Event> getEventsCollections() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore:
              (snapshot, options) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static Future<void> addUserInFireStore(MyUser user) {
    //todo:get collection
    var collectionRef = getUsersCollections();
    //todo: document
    //user.id will be get from auto created authentication id
    DocumentReference<MyUser> documentReference = collectionRef.doc(user.id);
    //todo:add data
    return documentReference.set(user);
    //ممكن نلخص الخطوات دي في سطر واحد
    getUsersCollections().doc(user.id).set(user);
  }

  //if the function returns no data so no necessary for async and await
  //but the next function returns data so we should make async and await
  static Future<MyUser?> readFromFirstore(String userId) async {
    //.get()=> get all data in the document
    DocumentSnapshot<MyUser> querySnapShot =
        await getUsersCollections().doc(userId).get();
    return querySnapShot.data();
  }

  static Future<void> addEventToFireStore(Event event) {
    var collectionRef = getEventsCollections();
    var documentRef = collectionRef.doc();
    //auto id
    event.eventId = documentRef.id;
    return documentRef.set(event);
  }
}
