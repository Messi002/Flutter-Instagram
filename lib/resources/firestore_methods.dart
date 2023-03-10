import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/resources/storage_method.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String descripText,
    String uid,
    Uint8List file,
  ) async {
    String res = 'Some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
    } catch (e) {
      print(e);
    }
  }
}
