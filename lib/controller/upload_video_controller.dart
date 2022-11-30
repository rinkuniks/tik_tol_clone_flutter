import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tik_tol_clone_flutter/model/video.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController extends GetxController {
  var uuid = Uuid();
  static VideoUploadController instance = Get.find();

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("user").doc(uid).get();
      //videoID - uuid
      String id = uuid.v1();
      String videoUrl = await _uploadVideoToStorage(id, videoPath);
      String thumbnail = await _uploadVideoThumbToStorage(id, videoPath);
      Video video = Video(
          uid: uid,
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          songName: songName,
          shareCount: 0,
          commentsCount: 0,
          likes: [],
          profilePic: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
          caption: caption,
          id: id);
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(id)
          .set(video.toJson());
      Get.snackbar(
          "Video Uploaded Successfully", "Thank You Sharing Your Content");
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print("====$e");
      }
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }

  Future<String> _uploadVideoToStorage(String videoID, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("videos").child(videoID);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadVidUrl = await snapshot.ref.getDownloadURL();
    return downloadVidUrl;
  }

  Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("thumbnail").child(id);
    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadThumbUrl = await snapshot.ref.getDownloadURL();
    return downloadThumbUrl;
  }

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    File? myFile = compressedVideo!.file;
    return myFile;
  }

  _getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }
}
