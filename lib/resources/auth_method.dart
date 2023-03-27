import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/model/user_model.dart';
import 'package:instagram/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//function to get user details
  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromJson(snapshot);
  }

  //sign up user
  Future<String> signUpUser({
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

//making sure that upload image works first

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        final UserModel model = UserModel(
          username: username,
          uid: uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        //add user to firebase(Database)
        _firestore
            .collection('users')
            .doc(userCred.user!.uid)
            .set(model.toJson());

        res = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //loggin user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
