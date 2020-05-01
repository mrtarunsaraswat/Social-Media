import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText}) {
  return AppBar(
    title: Text(
      isAppTitle ? "Social Media" : titleText,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTitle ? "worksans" : "worksans",
        fontSize: isAppTitle ? 30.0 : 20.0,
        fontWeight: isAppTitle ? FontWeight.w400 : FontWeight.normal
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}