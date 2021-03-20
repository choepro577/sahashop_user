import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/components/saha_user/button/pickerColorButton.dart';

import '../../../../../const/constant.dart';

class SupportIcon extends StatefulWidget {
  @override
  _SupportIconState createState() => _SupportIconState();
}

class _SupportIconState extends State<SupportIcon> {
  bool isShowHotline = false;

  Color colorIconHotline;

  changeColorIconHotline(Color color) =>
      setState(() => colorIconHotline = color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thêm hotline :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.phone,
              color: bmColors,
            ),
            Checkbox(
              tristate: false,
              value: isShowHotline,
              onChanged: (bool choose) {
                setState(() {
                  isShowHotline = choose;
                });
              },
              activeColor: bmColors,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "- Màu Icon :",
              style: TextStyle(fontSize: 15),
            ),
            PickerColorButton(
                currentColor: colorIconHotline ?? Colors.transparent,
                onChange: changeColorIconHotline)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "- Số điện thoại :",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thêm email :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.email,
              color: bmColors,
            ),
            Checkbox(
              tristate: false,
              value: isShowHotline,
              onChanged: (bool choose) {
                setState(() {
                  isShowHotline = choose;
                });
              },
              activeColor: bmColors,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "- Màu Icon :",
              style: TextStyle(fontSize: 15),
            ),
            PickerColorButton(
                currentColor: colorIconHotline ?? Colors.transparent,
                onChange: changeColorIconHotline)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "- Email :",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thêm Facebook :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(12),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/facebook-2.svg"),
            ),
            Checkbox(
              tristate: false,
              value: isShowHotline,
              onChanged: (bool choose) {
                setState(() {
                  isShowHotline = choose;
                });
              },
              activeColor: bmColors,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "- Link Facebook :",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thêm Zalo :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/zalo.svg"),
            ),
            Checkbox(
              tristate: false,
              value: isShowHotline,
              onChanged: (bool choose) {
                setState(() {
                  isShowHotline = choose;
                });
              },
              activeColor: bmColors,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "- Link zalo :",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
      ],
    );
  }
}
