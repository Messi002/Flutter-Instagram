// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  UserModel({
    required this.username,
    required this.uid,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
      };

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    final json = snapshot.data()! as Map<String, dynamic>;
    return UserModel(
      username: json['username'] as String,
      uid: json['uid'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      photoUrl: json['photoUrl'] as String,
      followers: List.from(json['followers'] as List),
      following: List.from(json['following'] as List),
    );
  }

  UserModel copyWith({
    String? username,
    String? uid,
    String? email,
    String? bio,
    String? photoUrl,
    List? followers,
    List? following,
  }) {
    return UserModel(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  @override
  String toString() {
    return 'UserModel(username: $username, uid: $uid, email: $email, bio: $bio, photoUrl: $photoUrl, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.uid == uid &&
        other.email == email &&
        other.bio == bio &&
        other.photoUrl == photoUrl &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        photoUrl.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
