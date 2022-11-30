import 'package:flutter/material.dart';

import '../widgets/TikTokVideoPlayer.dart';
import '../widgets/album_rotater.dart';
import '../widgets/profile_butoon.dart';

class DisplayVideoScreen extends StatelessWidget {
  const DisplayVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: 10,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            //Sample checking
            // return Center(child: Text(index.toString()));
            return Stack(
              children: [
                TikTokVideoPlayer(
                  videoUrl: "",
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@Username",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "My caption is here",
                      ),
                      Text(
                        "Song name",
                        style: TextStyle(
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
                        top: MediaQuery.of(context).size.height / 3, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfileButton(
                          profilePhotoUrl: 'https://www.freepik.com/premium-vector/person-avatar-design_3600045.htm',
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 45,
                              color: Colors.white,
                            ),
                            Text(
                              'Like',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.reply,
                              size: 45,
                              color: Colors.white,
                            ),
                            Text(
                              'Share',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.comment,
                              size: 45,
                              color: Colors.white,
                            ),
                            Text(
                              'Comments',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AlbumRotator(profilePicUrl: '',)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
