import 'dart:io';
import 'package:tik_tol_clone_flutter/constant.dart';
import 'package:flutter/material.dart';
import 'package:tik_tol_clone_flutter/controller/upload_video_controller.dart';
import 'package:tik_tol_clone_flutter/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;

  AddCaptionScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {

  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  VideoUploadController videoUploadController = Get.put(VideoUploadController());

  Widget UploadContent = Text("Upload");

  uploadVid(){
    UploadContent = Text('Please wait...');
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.4,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputField(
                      controller: songNameController,
                      myIcon: Icons.music_note_outlined,
                      myLabelText: 'Song Name'),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputField(
                      controller: captionController,
                      myIcon: Icons.closed_caption,
                      myLabelText: 'Caption'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      videoUploadController.uploadVideo(
                          songNameController.text,
                          captionController.text,
                          widget.videoPath);
                    },
                    style:
                    ElevatedButton.styleFrom(primary: buttonColor),
                    child: UploadContent,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
