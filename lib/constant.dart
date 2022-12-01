import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tik_tol_clone_flutter/view/screens/add_video.dart';
import 'package:tik_tol_clone_flutter/view/screens/display_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

var pageIndex = [
  DisplayVideoScreen(),
  Text('Search'),
  AddVideoScreen(),
  Text('Messages'),
  Text('Profile'),
];

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];
