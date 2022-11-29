import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tol_clone_flutter/constant.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOption(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child:  const Center(
              child: Text(
                'Add video',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showDialogOption(BuildContext context) {
  return showDialog(context: context, builder: (context) =>
  SimpleDialog(
    children: [
      SimpleDialogOption(
        onPressed: ()=> videoPick(ImageSource.gallery),
        child:const Text('Gallery'),
      ),
      SimpleDialogOption(
        onPressed: ()=> videoPick(ImageSource.camera),
        child: const Text('Camera'),
      ),
      SimpleDialogOption(
        onPressed: (){
          Navigator.pop(context);
        },
        child: const Text('Close'),
      ),
    ],
  ));
}

videoPick(ImageSource src)async {
  final video = await ImagePicker().pickVideo(source: src);
  if(video != null){
    Get.snackbar('Video Selected', video.path);
  }else{
    Get.snackbar('Error selecting Video', 'Please choose a different video file..');
  }
}
