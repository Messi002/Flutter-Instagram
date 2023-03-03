import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> SignUpUser({
    required String username,
    required String bio,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      // ignore: unnecessary_null_comparison
      if (username.isNotEmpty ||
          bio.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          file != null) {
        //register user to firebase_auth
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = userCred.user!.uid;
        //add user to firebase(Database)
        _firestore.collection('users').doc(userCred.user!.uid).set({
          "username": username,
          "uid": uid,
          "email": email,
          "bio" : bio,
          "followers": [],
          "following": [],
        });

        res = 'Success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
