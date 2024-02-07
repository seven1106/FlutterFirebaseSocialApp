import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String profilePic;
  final String banner;
  final String description;

  final String uid;
  final bool isAuthenticated; // if guest or not
  final int karma;
  final List<String> followers;
  final List<String> following;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.banner,
    required this.description,
    required this.uid,
    required this.isAuthenticated,
    required this.karma,
    required this.followers,
    required this.following,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? banner,
    String? description,
    String? uid,
    bool? isAuthenticated,
    int? karma,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      banner: banner ?? this.banner,
      description: description ?? this.description,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      karma: karma ?? this.karma,
      followers: followers ?? this.followers,
      following: followers ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'banner': banner,
      'description': description,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'karma': karma,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      banner: map['banner'] ?? '',
      description: map['description'] ?? '',
      uid: map['uid'] ?? '',
      isAuthenticated: map['isAuthenticated'] ?? false,
      karma: map['karma']?.toInt() ?? 0,
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, banner: $banner, description: $description, uid: $uid, isAuthenticated: $isAuthenticated, karma: $karma, followers: $followers, following: $following)';
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.banner == banner &&
        other.description == description &&
        other.uid == uid &&
        other.isAuthenticated == isAuthenticated &&
        other.karma == karma &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return name.hashCode ^
    profilePic.hashCode ^
    banner.hashCode ^
    description.hashCode ^
    uid.hashCode ^
    isAuthenticated.hashCode ^
    karma.hashCode ^
    followers.hashCode ^
    following.hashCode;
  }
}
