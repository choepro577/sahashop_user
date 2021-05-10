import 'package:flutter/material.dart';

class SahaTextField extends StatefulWidget {
  final String labelText;
  final bool withAsterisk;
  final String suffix;
  final Icon icon;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final Function(String) validator;
  final bool obscureText;
  final TextInputType textInputType;
  final String hintText;
  final int maxLength;

  const SahaTextField(
      {Key key,
        @required this.labelText,
        this.withAsterisk = false,
        this.suffix,
        this.icon,
        this.controller,
        this.onChanged,
        this.onSubmitted,
        this.validator,
        this.obscureText,
        this.textInputType,
        this.hintText,
        this.maxLength})
      : super(key: key);

  @override
  _SahaTextFieldState createState() => _SahaTextFieldState();
}

class _SahaTextFieldState extends State<SahaTextField> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: TextFormField(
          validator: widget.validator,
          keyboardType:widget.textInputType,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          controller: widget.controller,
          maxLength: widget.maxLength,
          decoration: InputDecoration(

            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: widget.hintText,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 14, top: 10),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: ' ${widget.labelText}',
                  style: TextStyle(
                      color: Colors.black54,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
              TextSpan(
                  text: widget.withAsterisk ? '* ' : ' ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      color: Colors.red)),
            ],
          ),
        ),
      ),
    ]);
  }
}
