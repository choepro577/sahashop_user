import 'package:sahashop_user/const/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SahashopTextField extends StatelessWidget {
  String labelText;
  Icon icon;
  TextEditingController controller;
  Function(String) onChanged;
  Function(String) validator;
  bool obscureText;
  TextInputType textInputType;
  String hintText;

  SahashopTextField({
    this.labelText,
    this.controller,
    this.icon,
    this.hintText,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: TextFormField(
        validator: validator,
        keyboardType: textInputType,
        obscureText: obscureText,
        onChanged: onChanged,
        controller: controller,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),),
            labelText: labelText,
            hintText: hintText,
            suffixIcon: icon,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixStyle: const TextStyle(color: bmColors)),
      ),
    );
  }
}