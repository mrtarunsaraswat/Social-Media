import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:socialmedia/util/custom_text_field.dart';
import 'package:socialmedia/widgets/customButton.dart';
import 'package:socialmedia/widgets/iconavtar.dart';
import 'package:socialmedia/widgets/paddingwidgets.dart';
import 'package:socialmedia/widgets/textboxheadings.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: RefreshProgressIndicator(),
        dismissible: true,
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontFamily: 'worksans',
                        fontWeight: FontWeight.w600,
                        fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconAvatar(
                  path: "assets/sad.png",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Enter the email address \n associated with your account.',
                        style: TextStyle(
                            fontFamily: 'worksans',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'We will send you a link to reset \n your password.',
                        style: TextStyle(
                            fontFamily: 'worksans',
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                TextBoxHeading('Email'),
                PaddingWidget(child: CustomTextField(
                  validator: _validateEmail,
                  onChanged: (value) {
                    email = value;
                  },
                  hintText: 'Enter your Email',
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PaddingWidget(
                    child: MyCustomButton(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          forgotPassword();
                        }
                      },
                      heading: 'Reset Password',
                      color: Colors.blue[700],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  void forgotPassword() async {
    setState(() {
      showSpinner = true;
    });
    _auth.sendPasswordResetEmail(email: email).then((result) {
      _showScaffold("Forgot password link send to your registered email address successfully");
      setState(() {
        showSpinner = false;
      });
    }).catchError((error) {
      _showScaffold("Sorry,This email is not register with us, Please check your email");
      setState(() {
        showSpinner = false;
      });
    });
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
