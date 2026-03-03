import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/user_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required UserRepository userRepository})
      : _repo = userRepository,
        super(const ProfileLoading()) {
    on<ProfileLoadRequested>(_onLoad);
  }

  final UserRepository _repo;

  Future<void> _onLoad(ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    try {
      final user = await _repo.getUser(event.uid);
      if (user == null) {
        emit(const ProfileError('Профиль не найден в Firestore'));
      } else {
        emit(ProfileLoaded(user));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}