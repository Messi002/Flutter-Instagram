// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final String postUrl;
  final datePublished;
  final String profileImage;
  final likes;

  PostModel({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.postUrl,
    required this.datePublished,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'uid': uid,
      'username': username,
      'postId': postId,
      'photoUrl': postUrl,
      'datePublished': datePublished,
      'profileImage': profileImage,
      'likes': likes,
    };
  }

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      description: snapshot['description'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      postUrl: snapshot['photoUrl'],
      datePublished: snapshot['datePublished'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
    );
  }

  @override
  String toString() {
    return 'PostModel(description: $description, uid: $uid, username: $username, postId: $postId, photoUrl: $postUrl, datePublished: $datePublished, profileImage: $profileImage,)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.uid == uid &&
        other.username == username &&
        other.postId == postId &&
        other.postUrl == postUrl &&
        other.datePublished == datePublished &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        uid.hashCode ^
        username.hashCode ^
        postId.hashCode ^
        postUrl.hashCode ^
        datePublished.hashCode ^
        profileImage.hashCode;
  }
}
