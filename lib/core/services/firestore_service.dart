import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> users() =>
      _db.collection('users');

  CollectionReference<Map<String, dynamic>> recycleEvents() =>
      _db.collection('recycle_events');

  Future<Map<String, dynamic>?> getUser(String uid) async {
    final doc = await users().doc(uid).get();
    return doc.data();
  }

  Future<void> setUser(String uid, Map<String, dynamic> data) async {
    await users().doc(uid).set(data, SetOptions(merge: true));
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await users().doc(uid).update(data);
  }

  Future<void> addRecycleEventAndUpdateBonus({
    required String uid,
    required Map<String, dynamic> eventData,
    required int bonusDelta,
  }) async {
    await _db.runTransaction((tx) async {
      final userRef = users().doc(uid);
      final userSnap = await tx.get(userRef);

      final current =
          (userSnap.data()?['bonusBalance'] as num?)?.toInt() ?? 0;

      tx.set(
        userRef,
        {
          'bonusBalance': current + bonusDelta,
        },
        SetOptions(merge: true),
      );

      final eventRef = recycleEvents().doc();
      tx.set(eventRef, eventData);
    });
  }
}