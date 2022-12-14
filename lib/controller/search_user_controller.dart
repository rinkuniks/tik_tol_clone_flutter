import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tol_clone_flutter/model/user.dart';

class SearchUserController extends GetxController {
  final Rx<List<MyUser>> _searchUsers = Rx<List<MyUser>>([]);

  List<MyUser> get searchedUser => _searchUsers.value;

  searchUser(String query) async {
    _searchUsers.bindStream(FirebaseFirestore.instance
        .collection('user')
        .where('name', isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((QuerySnapshot queryRes) {
      List<MyUser> retVal = [];
      for (var ele in queryRes.docs) {
        retVal.add(MyUser.fromSnap(ele));
      }
      return retVal;
    }));
  }
}
