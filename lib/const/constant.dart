import 'package:flutter/material.dart';

const bmColors = Color(0xFFFF7643);
const SahaPrimaryColor = Color(0xFF22B9B5);
const SahaPrimaryLightColor = Color(0xFF52D5D1);
const SahaBorderColor = Color(0xFFF2F2F2);
const SahaSecondaryColor = Color(0xFF979797);
const SahaTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: (28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
// Form
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
