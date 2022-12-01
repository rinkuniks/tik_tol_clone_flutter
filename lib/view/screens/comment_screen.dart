import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tol_clone_flutter/controller/comment_controller.dart';
import 'package:tik_tol_clone_flutter/view/widgets/text_input.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;

  CommentScreen({
    required this.id,
  });

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final commentss = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(commentss.profilePic),
                          ),
                          title: Row(
                            children: [
                              Text(
                                commentss.username,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                commentss.comment,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(commentss.datePub.toDate()),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("${commentss.likes.length} Likes",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () {
                                commentController.likeComment(commentss.id);
                              },
                              child: Icon(
                                Icons.favorite,
                                color: commentss.likes.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Colors.red
                                    : Colors.white,
                              )),
                        );
                      });
                }),
              ),
              const Divider(),
              ListTile(
                title: TextInputField(
                  myIcon: Icons.comment,
                  controller: _commentController,
                  myLabelText: 'Comment',
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(_commentController.text);
                  },
                  child: Text('Send'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
