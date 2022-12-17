import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tik_tol_clone_flutter/view/screens/add_video.dart';
import 'package:tik_tol_clone_flutter/view/screens/display_screen.dart';
import 'package:tik_tol_clone_flutter/view/screens/profile_screen.dart';
import 'package:tik_tol_clone_flutter/view/screens/search_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

var pageIndex = [
  DisplayVideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Text('Coming soon in new Update!'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];
