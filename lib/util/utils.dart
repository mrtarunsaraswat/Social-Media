import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

InputDecoration textDecoration(String label) {
  return InputDecoration(
    filled: true,
    isDense: true,
    hintStyle: TextStyle(fontFamily: 'worksans', fontWeight: FontWeight.w400),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(04))),

    border:  OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(04))
    ),

    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(04))),

    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(04))),

    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(04))),
    // hintText: 'Enter your product title',
    labelStyle: TextStyle(color: Colors.grey[700]),
    errorStyle: TextStyle(
      color: Colors.red,
    ),
    hintText: label,
  );
}

String _validateEmail(String value) {
  if (value.isEmpty) {
    // The form is empty
    return "Enter email address";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Email is not valid';
}

InputDecoration spinnerDecoration(String label) {
  return InputDecoration(
    filled: true,
    isDense: true,
    hintStyle: TextStyle(fontFamily: 'worksans', fontWeight: FontWeight.w400,fontSize: 13),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(04))),

    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(04))
    ),

    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(04))),

    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(04))),

    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    // hintText: 'Enter your product title',
    labelStyle: TextStyle(color: Colors.grey[700]),
    errorStyle: TextStyle(
      color: Colors.red,
    ),
    hintText: label,
  );
}