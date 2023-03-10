import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/model/post_model.dart';
import 'package:instagram/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final userId = FirebaseAuth.instance.currentUser!.uid;
  


  //upload post
  Future<String> uploadPost(
    String description,
    String uid,
    Uint8List file,
    String username,
    String profileImage,
  ) async {
    String res = 'Some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      PostModel post = PostModel(
        description: description,
        uid: userId,
        username: username,
        postId: postId,
        postUrl: photoUrl,
        datePublished: DateTime.now(),
        profileImage: profileImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = 'Succesful Upload.';
    } catch (e) {
      res = e.toString();
      log(e.toString());
    }

    return res;
  }
}
