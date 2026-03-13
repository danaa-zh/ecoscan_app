import 'package:equatable/equatable.dart';

class RecycleEventModel extends Equatable {
  const RecycleEventModel({
    required this.uid,
    required this.type,
    required this.count,
    required this.bonusEarned,
    required this.createdAtMillis,
    required this.locationName,
  });

  final String uid;
  final String type; 
  final int count;
  final int bonusEarned;
  final int createdAtMillis;
  final String locationName;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'type': type,
        'count': count,
        'bonusEarned': bonusEarned,
        'createdAtMillis': createdAtMillis,
        'locationName': locationName,
      };

  @override
  List<Object?> get props => [uid, type, count, bonusEarned, createdAtMillis, locationName];
}