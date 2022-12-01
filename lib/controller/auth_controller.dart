import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tol_clone_flutter/model/user.dart';
import 'package:tik_tol_clone_flutter/view/screens/auth/login_screen.dart';
import 'package:tik_tol_clone_flutter/view/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instanse = Get.find();
  File? proImg;

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
        String url = await _uploadProPic(image);
        MyUser user = MyUser(
            name: username,
            profilePhoto: url,
            email: email,
            uid: credential.user!.uid);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error creating an account",
            "Please enter all the required fields..");
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

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final img = File(image.path);
    proImg = img;
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar(
            "Error Login-in", "Please enter all the required fields..");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        Get.snackbar("Error Occurred", e.toString());
      }
    }
  }

  //User State persistence
  late Rx<User?> _user;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    //Rx - Observable conti. checks that data in variable
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setLoginView);
  }

  _setLoginView(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }
}
