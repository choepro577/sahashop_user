import 'package:flutter/material.dart';
import 'package:sahashop_user/const/constant.dart';

class SahaButtonFullParent extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color textColor;
  final Color color;

  const SahaButtonFullParent(
      {Key key, this.onPressed, this.text, this.textColor, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: MaterialButton(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        color: onPressed == null ? Colors.grey : (color ?? SahaPrimaryColor),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$text",
              style: TextStyle(color: textColor ?? Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class SahaButtonSizeChild extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color textColor;
  final Color color;

  const SahaButtonSizeChild(
      {Key key, this.onPressed, this.text, this.textColor, this.color})
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
          onPressed();
        },
        child: Text(
          "$text",
          style: TextStyle(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
