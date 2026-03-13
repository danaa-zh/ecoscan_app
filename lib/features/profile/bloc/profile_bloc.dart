import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/firestore_service.dart';

class ProfileBloc extends Cubit<Map<String, dynamic>?> {
  ProfileBloc(this._db) : super(null);

  final FirestoreService _db;

  Future<void> loadProfile(String uid) async {
    final data = await _db.getUser(uid);
    emit(data);
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _db.updateUser(uid, data);
    await loadProfile(uid);
  }
}