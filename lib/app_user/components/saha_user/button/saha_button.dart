import 'package:flutter/material.dart';
import 'package:sahashop_user/app_user/const/constant.dart';

class SahaButtonFullParent extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final Color? textColor;
  final Color? color;
  final Color? colorBorder;

  const SahaButtonFullParent(
      {Key? key,
      this.onPressed,
      this.text,
      this.textColor,
      this.color,
      this.colorBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            side: colorBorder == null
                ? BorderSide(width: 0, color: Colors.transparent)
                : BorderSide(
                    width: 1.0,
                    color: colorBorder!,
                  ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed as void Function()?,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 3, bottom: 3),
                  child: Text(
                    "$text",
                    style: TextStyle(color: textColor ?? Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SahaButtonSizeChild extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final Color? textColor;
  final Color? color;

  const SahaButtonSizeChild(
      {Key? key, this.onPressed, this.text, this.textColor, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: MaterialButton(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        color: onPressed == null ? Colors.grey : (color ?? SahaPrimaryColor),
        onPressed: () {
          onPressed!();
        },
        child: Text(
          "$text",
          style: TextStyle(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
