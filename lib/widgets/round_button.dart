import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final IconData icon;

  RoundButton({this.onTap, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        radius: 25,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
