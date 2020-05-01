import 'package:socialmedia/widgets/paddingwidgets.dart';
import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String heading;
  final Function onTap;
  final Color color;


  MyCustomButton({this.heading, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        height: 45,
        child: Text(
          '$heading'.toUpperCase(),
          style: TextStyle(color: Colors.white, fontFamily: 'worksans',fontSize: 15),
        ),
        color: color,
      ),
    );
  }
}