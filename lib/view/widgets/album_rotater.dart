import 'package:flutter/material.dart';

class AlbumRotator extends StatelessWidget {
  const AlbumRotator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.white],
              ),
              borderRadius: BorderRadius.circular(35),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image(
                image: NetworkImage(
                    "https://www.freepik.com/premium-vector/person-avatar-design_3600045.htm"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
