import '../../core/services/firestore_service.dart';
import '../models/user_model.dart';

class UserRepository {
  UserRepository({required FirestoreService firestore}) : _firestore = firestore;

  final FirestoreService _firestore;

  Future<UserModel?> getUser(String uid) async {
    final data = await _firestore.getUser(uid);
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  Future<void> upsertUser(UserModel user) {
    return _firestore.setUser(user.uid, user.toJson());
  }
}