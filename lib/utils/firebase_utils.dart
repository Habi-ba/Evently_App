import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  //todo:for every User => his own Events
  static CollectionReference<Event> getEventsCollections1(String uId) {
    return getUsersCollections()
        .doc(uId)
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

  //todo:Real time changes
  static Stream<List<Event>> getAllEvents2() {
    Stream<QuerySnapshot<Event>> stream =
        FirebaseUtils.getEventsCollections().orderBy('event_date').snapshots();
    return stream.map((querySnapshot) {
      //todo:List<QueryDocumentSnapShot<Event>> => eventList
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  //todo:filter events
  static Stream<List<Event>> getAllFilteredEvents({
    required int selectedIndex,
  }) {
    Stream<QuerySnapshot<Event>> stream =
        FirebaseUtils.getEventsCollections()
            .where('event_category_index', isEqualTo: selectedIndex)
            .orderBy('event_date')
            .snapshots();
    return stream.map((querySnapshot) {
      //todo:List<QueryDocumentSnapShot<Event>> => eventList
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  //todo:update
  static Future<void> updateIsFavourite(Event event) {
    return getEventsCollections().doc(event.eventId).update({
      'is_favourite': !event.isFavourite,
    });
  }

  static Future<void> updateEvent(Event event) {
    return getEventsCollections().doc(event.eventId).set(event);
  }

  static Stream<List<Event>> getAllFavouriteEvents() {
    return getEventsCollections()
        .where('is_favourite', isEqualTo: true)
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }

  static Future<void> deleteEvent(Event event) {
    return getEventsCollections().doc(event.eventId).delete();
  }

  static Stream<Event> getEventStream(String eventId) {
    return getEventsCollections().doc(eventId).snapshots().map((snapshot) {
      return snapshot.data()!;
    });
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn.instance.authenticate();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
//manual sort and filter
/*
                     if(selectedIndex==0){
                        filterEventList=eventList;
                        //todo:sort
                        filterEventList.sort((event1, event2) {
                          return event1.eventDate.compareTo(event2.eventDate);
                        },);
                      }
                      else{
                        //todo:filter
                        filterEventList=eventList.where((event) {
                          return event.eventCategoryIndex==selectedIndex;

                        },).toList();
                        //todo:sort
                        filterEventList.sort((event1, event2) {
                          return event1.eventDate.compareTo(event2.eventDate);
                        },);

                      }
                      return filterEventList.isEmpty?
                      Center(
                        child:Text(LocaleKeys.no_events_found_yet.tr(),style:
                        Theme.of(context).textTheme.bodyLarge,) ,
                      ):
 */
//todo:one time read

// void getAllEvents1() async {
//   var querySnapshot = await FirebaseUtils.getEventsCollections().get();
//   //todo:List<QueryDocumentSnapShot<Event>> => eventList
//   eventList =
//       querySnapshot.docs.map((doc) {
//         return doc.data();
//       }).toList();
//   setState(() {});
// }
