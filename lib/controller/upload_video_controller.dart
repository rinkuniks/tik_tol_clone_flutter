import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController extends GetxController {
  var uuid = const Uuid();

  uploadVideo(String songName, String caption, String videoPath) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    //VideoId - uuid
    //v1 is for time based
    String id = uuid.v1();
    _uploadVideoToStorage(id, videoPath);

    String thumbnail = await _uploadVideoThumbToStorage(id, videoPath);
  }
}

Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
  Reference reference =
      FirebaseStorage.instance.ref().child('thumbnail').child(id);
  UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future<String> _uploadVideoToStorage(String videoId, String videoPath) async {
  Reference reference =
      FirebaseStorage.instance.ref().child('videos').child(videoId);
  UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

_compressVideo(String videoPath) async {
  final compressedVideo = await VideoCompress.compressVideo(videoPath,
      quality: VideoQuality.MediumQuality);
  return compressedVideo!.file;
}

Future<File> _getThumb(String videoPath) async {
  final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
  return thumbnail;
}
