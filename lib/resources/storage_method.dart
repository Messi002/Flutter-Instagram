import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    final userId = _auth.currentUser!.uid;

    Reference ref = _storage.ref().child(childName).child(userId);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask =
        ref.putData(file); //It is like a future but isn't actually

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}




// Future<bool> uploadImage({required File file, required String userId}) =>
//     FirebaseStorage.instance
//         .ref(userId)
//         .child(const Uuid().v4())
//         .putFile(file)
//         .then((_) => true)
//         .catchError((_) => false);