import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:socialmedia/util/custom_text_field.dart';
import 'package:socialmedia/util/passwordField.dart';
import 'package:socialmedia/widgets/customButton.dart';
import 'package:socialmedia/widgets/iconavtar.dart';
import 'package:socialmedia/widgets/paddingwidgets.dart';
import 'package:socialmedia/widgets/round_button.dart';
import 'package:socialmedia/widgets/textboxheadings.dart';

import 'forgotpassword.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  GoogleSignInAccount _currentUser;
  bool isLoggedIn = false;
  var profileData;
  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: RefreshProgressIndicator(),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                          fontFamily: 'worksans',
                          fontWeight: FontWeight.w600,
                          fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconAvatar(
                    path: "assets/welcome.png",
                  ),
                  TextBoxHeading('Email'),
                  Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                      child: _buildEmailField()),
                  TextBoxHeading('Password'),
                  Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 30),
                      child: _buildPasswordField()),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                                fontFamily: 'worksans',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                        ),
                      ],
                    ),
                  ),
                  PaddingWidget(
                    child: MyCustomButton(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          _loginWithEmail();
                        }
                      },
                      heading: 'Signin with E-mail',
                      color: Colors.blue[700],
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                          const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text("OR"),
                    Expanded(
                      child: new Container(
                          margin:
                          const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RoundButton(
                            onTap: () => _loginWithGoogle(),
                            color: Color(0xFF4285F4),
                            icon: FontAwesome5Brands.google),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Don\'t have an account?',
                                  style: TextStyle(
                                      fontFamily: 'worksans',
                                      color: Colors.black,
                                      fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Create an account',
                                        style: TextStyle(
                                            fontFamily: 'worksans',
                                            color: Colors.blueAccent,
                                            fontSize: 16),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                new CupertinoPageRoute(
                                                    builder: (context) =>
                                                        SignIn())); // navigate to desired screen
                                          })
                                  ]),
                            ),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }

  Widget _buildEmailField() {
    return CustomTextField(
      validator: _validateEmail,
      onChanged: (value) {
        email = value;
      },
      hintText: 'Enter your Email',
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(
      validator: (String value) {
        if (value.trim().isEmpty) {
          return 'Please enter your password.';
        }
        return null;
      },
      onChanged: (value) {
        password = value;
      },
      hintText: 'Enter your Password',
    );
  }

  void _loginWithEmail() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        setState(() {
          showSpinner = false;
        });
        Navigator.push(context,
            new CupertinoPageRoute(builder: (context) => SignIn()));
      }
    } catch (e) {
      setState(() {
        _showScaffold("Wrong Credentials please check your email & passoword ");
        showSpinner = false;
      });
      print(e);
    }
  }

  void _loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
