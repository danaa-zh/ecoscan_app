import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.name,
    required this.surname,
    required this.level,
    required this.bonusBalance,
    required this.photoUrl,
    required this.createdAtMillis,
  });

  final String uid;
  final String email;
  final String username;
  final String name;
  final String surname;
  final int level;
  final int bonusBalance;
  final String photoUrl;
  final int createdAtMillis;

  static const empty = UserModel(
    uid: '',
    email: '',
    username: '',
    name: '',
    surname: '',
    level: 1,
    bonusBalance: 0,
    photoUrl: '',
    createdAtMillis: 0,
  );

  bool get isEmpty => uid.isEmpty;
  bool get isNotEmpty => uid.isNotEmpty;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: (json['uid'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      username: (json['username'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      surname: (json['surname'] ?? '') as String,
      level: (json['level'] as num?)?.toInt() ?? 1,
      bonusBalance: (json['bonusBalance'] as num?)?.toInt() ?? 0,
      photoUrl: (json['photoUrl'] ?? '') as String,
      createdAtMillis: (json['createdAtMillis'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'name': name,
        'surname': surname,
        'level': level,
        'bonusBalance': bonusBalance,
        'photoUrl': photoUrl,
        'createdAtMillis': createdAtMillis,
      };

  UserModel copyWith({
    String? username,
    String? name,
    String? surname,
    int? level,
    int? bonusBalance,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      level: level ?? this.level,
      bonusBalance: bonusBalance ?? this.bonusBalance,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAtMillis: createdAtMillis,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        username,
        name,
        surname,
        level,
        bonusBalance,
        photoUrl,
        createdAtMillis,
      ];
}