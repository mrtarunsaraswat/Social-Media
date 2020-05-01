import 'package:flutter/material.dart';
class TextBoxHeading extends StatelessWidget {
  final String heading;

  TextBoxHeading(this.heading);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: 16.0, right: 25.0, top: 10.0,bottom: 5),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Column(
              mainAxisAlignment:
              MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  '$heading *',
                  style: TextStyle(
                      fontFamily: 'worksans',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ));
  }
}