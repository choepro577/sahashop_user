import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class SahaMoneyText extends StatelessWidget {
  double price;
  double sizeVND;
  double sizeText;
  Color color;
  FontWeight fontWeight;

  SahaMoneyText(
      {this.price,
      this.sizeVND = 16,
      this.sizeText = 19,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Text(
          "đ",
          style: TextStyle(
              fontSize: sizeVND,
              decoration: TextDecoration.underline,
              color: color),
        ),
        Text(
          "${SahaStringUtils().convertToMoney(price)}",
          style: TextStyle(
              fontSize: sizeText, fontWeight: FontWeight.w500, color: color),
          maxLines: 2,
        ),
      ],
    );
  }
}
