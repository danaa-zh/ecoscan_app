import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/recycle_event_model.dart';
import '../../../data/repositories/recycle_repository.dart';
import 'scan_event.dart';
import 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc({required RecycleRepository recycleRepository})
      : _repo = recycleRepository,
        super(const ScanIdle()) {
    on<ScanSubmitRequested>(_onSubmit);
    on<ScanReset>((_, emit) => emit(const ScanIdle()));
  }

  final RecycleRepository _repo;

  Future<void> _onSubmit(ScanSubmitRequested event, Emitter<ScanState> emit) async {
    emit(const ScanProcessing());
    try {
      // Simple bonus formula (change later):
      final bonus = event.count * 5;

      final model = RecycleEventModel(
        uid: event.uid,
        type: event.type,
        count: event.count,
        bonusEarned: bonus,
        createdAtMillis: DateTime.now().millisecondsSinceEpoch,
        locationName: event.locationName,
      );

      await _repo.addEvent(uid: event.uid, event: model);
      emit(ScanSuccess(bonus));
    } catch (e) {
      emit(ScanFailure(e.toString()));
    }
  }
}