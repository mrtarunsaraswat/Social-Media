import 'package:flutter/material.dart';

class IconAvatar extends StatelessWidget {
  final String path;

  IconAvatar({this.path});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 85,
      backgroundColor: Colors.grey[300],
      child: Image.asset(
        path,
        height: 130,
      ),
    );
  }
}