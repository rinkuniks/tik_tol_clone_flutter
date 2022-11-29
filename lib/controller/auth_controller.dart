import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //User register
  void signUp(
    String username,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        _uploadProPic(image);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        Get.snackbar("Error Occurred", e.toString());
      }
    }
  }

  Future<String> _uploadProPic(File img) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(img);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }
}
