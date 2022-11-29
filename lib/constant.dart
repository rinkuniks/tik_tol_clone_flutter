import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tik_tol_clone_flutter/view/screens/add_video.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

const pageIndex = [
  Text('Home'),
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
