import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tol_clone_flutter/controller/auth_controller.dart';
import 'package:tik_tol_clone_flutter/model/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(FirebaseFirestore.instance
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Video> retVal = [];
      for (var element in querySnapshot.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }

  likedVideo(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("videos").doc(id).get();
    var uid = AuthController.instanse.user.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  shareVideo(String vidId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("videos").doc(vidId).get();

    int newShareCount = (doc.data() as dynamic)["shareCount"] + 1;
    await FirebaseFirestore.instance
        .collection("videos")
        .doc(vidId)
        .update({"shareCount": newShareCount});
  }
}
