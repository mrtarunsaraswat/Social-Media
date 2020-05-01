import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/widgets/customButton.dart';
import 'package:socialmedia/widgets/header.dart';
import 'package:socialmedia/widgets/paddingwidgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "Profile"),
      body: Center(child: PaddingWidget(
        child: Column(
          children: <Widget>[
            MaterialButton(
              onPressed: logout,
              child: Text('Logout'),
              color: Colors.red,
            ),
            MyCustomButton(
              onTap: logout(),
              heading: 'Logout',
              color: Colors.red,
            )
          ],
        )
      )));
  }
  logout() {
    googleSignIn.signOut();
  }
}
