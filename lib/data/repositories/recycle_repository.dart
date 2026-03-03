import '../../core/services/firestore_service.dart';
import '../models/recycle_event_model.dart';

class RecycleRepository {
  RecycleRepository({required FirestoreService firestore}) : _firestore = firestore;
  final FirestoreService _firestore;

  Future<void> addEvent({
    required String uid,
    required RecycleEventModel event,
  }) async {
    await _firestore.addRecycleEventAndUpdateBonus(
      uid: uid,
      eventData: event.toJson(),
      bonusDelta: event.bonusEarned,
    );
  }
}