import 'package:sahashop_user/const/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SahaTextField extends StatelessWidget {
  String labelText;
  String suffix;
  Icon icon;
  TextEditingController controller;
  Function(String) onChanged;
  Function(String) onSubmitted;
  Function(String) validator;
  bool obscureText;
  TextInputType textInputType;
  String hintText;

  SahaTextField({
    this.labelText,
    this.suffix = "",
    this.controller,
    this.icon,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      child: TextFormField(
        validator: validator,
        keyboardType: textInputType,
        obscureText: obscureText,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        controller: controller,
        decoration: new InputDecoration(
            suffix: Text(suffix),
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            labelText: labelText,
            hintText: hintText,
            suffixIcon: obscureText == true && icon != null ? icon : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixStyle: const TextStyle(color: bmColors)),
      ),
    );
  }
}
