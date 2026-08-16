import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/my_user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollections() {
    //ل coverterهي الي بتعرف ال  فايرستور ايه النوع الي بتخزنه
    //snapshot is an instance of a document we should access the data inside it
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (user, options) => user.toJson());
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
}
