import 'package:flutter/material.dart';

class AlbumRotator extends StatefulWidget {
  String profilePicUrl;

  AlbumRotator({Key? key, required this.profilePicUrl}) : super(key: key);

  @override
  State<AlbumRotator> createState() => _AlbumRotatorState();
}

class _AlbumRotatorState extends State<AlbumRotator> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 5));
    animationController.forward();
    animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0,end: 1.0).animate(animationController),
      child: SizedBox(
        height: 70,
        width: 70,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.grey, Colors.white],
                ),
                borderRadius: BorderRadius.circular(35),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: const Image(
                  //NetworkImage(profilePicUrl),
                  image: NetworkImage(
                    "https://www.freepik.com/premium-vector/person-avatar-design_3600045.htm",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
