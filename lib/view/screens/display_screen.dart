import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:tik_tol_clone_flutter/view/screens/profile_screen.dart';

import '../../controller/video_controller.dart';
import '../widgets/TikTokVideoPlayer.dart';
import '../widgets/album_rotater.dart';
import '../widgets/profile_butoon.dart';
import 'comment_screen.dart';

class DisplayVideoScreen extends StatelessWidget {
  DisplayVideoScreen({Key? key}) : super(key: key);
  final VideoController videoController = Get.put(VideoController());

  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download My TikTok Clone App',
      text: 'Watch Interesting short videos On TikTok Clone',
    );
    videoController.shareVideo(vidId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              //Sample checking
              // return Center(child: Text(index.toString()));
              return InkWell(
                onDoubleTap: () {
                  videoController.likedVideo(data.id);
                },
                child: Stack(
                  children: [
                    TikTokVideoPlayer(
                      videoUrl: data.videoUrl,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.username,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            data.caption,
                          ),
                          Text(
                            data.songName,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 400,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3,
                            right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileScreen(uid: data.uid)));
                              },
                              child: ProfileButton(
                                profilePhotoUrl: data.profilePic,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                videoController.likedVideo(data.id);
                              },
                              child: Column(
                                children: [
                                   Icon(
                                    Icons.favorite,
                                    size: 45,
                                    color: data.likes.contains(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        ? Colors.pinkAccent
                                        : Colors.white,
                                  ),
                                  Text(
                                    data.likes.length.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                share(data.id);
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.reply,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.shareCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommentScreen(id: data.id)));
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.comment,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.commentsCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AlbumRotator(
                                    profilePicUrl: data.profilePic,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
