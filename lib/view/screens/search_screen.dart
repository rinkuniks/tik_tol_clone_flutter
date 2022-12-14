import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tol_clone_flutter/model/user.dart';

import '../../controller/search_user_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchQuery = TextEditingController();
  final SearchUserController searchUserController =
      Get.put(SearchUserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
            title: TextFormField(
          decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: 'Search Username'),
          controller: searchQuery,
          onFieldSubmitted: (value) {
            searchUserController.searchUser(value);
          },
        )),
        body: searchUserController.searchedUser.isEmpty
            ? const Center(
                child: Text('Search users !'),
              )
            : ListView.builder(
                itemCount: searchUserController.searchedUser.length,
                itemBuilder: (context, index) {
                  MyUser user = searchUserController.searchedUser[index];
                  return ListTile(
                    onTap: () {
                      Get.snackbar('You Clicked ${user.name}',
                          'Opening ProfilePage of it.');
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePhoto),
                    ),
                    title: Text(user.name),
                  );
                }),
      );
    });
  }
}
