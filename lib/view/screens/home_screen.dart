import 'package:flutter/material.dart';
import 'package:tik_tol_clone_flutter/constant.dart';
import 'package:tik_tol_clone_flutter/view/widgets/custom_add_icon.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pageIdx = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              label: 'Search'),
          BottomNavigationBarItem(icon: CustomAddIcon(), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 25,
              ),
              label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 25,
              ),
              label: 'Profile'),
        ],
      ),
      body: Center(
        child: pageIndex[pageIdx],
      ),
    );
  }
}
