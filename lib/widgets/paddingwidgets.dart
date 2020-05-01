import 'package:flutter/material.dart';
class PaddingWidget extends StatelessWidget {
  final Widget child;

  PaddingWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16,left: 16,bottom: 10),
      child: child,
    );
  }
}