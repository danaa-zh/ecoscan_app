import 'package:equatable/equatable.dart';

sealed class ScanEvent extends Equatable {
  const ScanEvent();
  @override
  List<Object?> get props => [];
}

class ScanSubmitRequested extends ScanEvent {
  const ScanSubmitRequested({
    required this.uid,
    required this.type,
    required this.count,
    required this.locationName,
  });

  final String uid;
  final String type;
  final int count;
  final String locationName;

  @override
  List<Object?> get props => [uid, type, count, locationName];
}

class ScanReset extends ScanEvent {
  const ScanReset();
}