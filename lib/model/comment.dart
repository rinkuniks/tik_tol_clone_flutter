import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePub;
  List likes;
  String profilePic;
  String id;
  String uid;

  Comment({
    required this.comment,
    required this.username,
    required this.datePub,
    required this.likes,
    required this.profilePic,
    required this.id,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
    'comment': comment,
    'username': username,
    'datePub': datePub,
    'likes': likes,
    'profilePic': profilePic,
    'id': id,
    'uid': uid,
  };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      comment: snapshot['comment'],
      username: snapshot['username'],
      datePub: snapshot['datePub'],
      uid: snapshot['uid'],
      likes: snapshot['likes'],
      profilePic: snapshot['profilePic'],
      id: snapshot['id'],
    );
  }
}
