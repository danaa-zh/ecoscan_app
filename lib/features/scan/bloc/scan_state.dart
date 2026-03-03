import 'package:equatable/equatable.dart';

sealed class ScanState extends Equatable {
  const ScanState();
  @override
  List<Object?> get props => [];
}

class ScanIdle extends ScanState {
  const ScanIdle();
}

class ScanProcessing extends ScanState {
  const ScanProcessing();
}

class ScanSuccess extends ScanState {
  const ScanSuccess(this.bonusEarned);
  final int bonusEarned;
  @override
  List<Object?> get props => [bonusEarned];
}

class ScanFailure extends ScanState {
  const ScanFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}