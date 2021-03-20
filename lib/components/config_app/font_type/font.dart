import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/components/saha_user/button/pickerColorButton.dart';
import 'package:sahashop_user/components/saha_user/dropDownCustom/dropDownButton.dart';
import 'package:sahashop_user/screen/config_app/constantConfig/contansConfig.dart';

class FontConfig extends StatefulWidget {
  @override
  _FontConfigState createState() => _FontConfigState();
}

class _FontConfigState extends State<FontConfig> {
  Map<String, dynamic> value;

  String fontNormal;
  String fontSub;
  String fontTitle;


  Color colorTitle;
  changeColorTitle(Color color) => setState(() => colorTitle = color);


  Color colorNormal;
  changeColorNormal(Color color) => setState(() => colorNormal = color);

  Color colorSub;
  changeColorSub(Color color) => setState(() => colorSub = color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cỡ chữ tiêu đề",
              style: TextStyle(fontSize: 16),
            ),
            DropDownButtonCustom(
              value: fontTitle,
              item: fontSizeConfig,
              title: "Chọn cỡ chữ",
              onChange: (value) {
                setState(() {
                  fontTitle = value;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Màu tiêu đề",
              style: TextStyle(fontSize: 16),
            ),
            PickerColorButton(
                currentColor: colorTitle ?? Colors.transparent,
                onChange: changeColorTitle)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cỡ chữ thường",
              style: TextStyle(fontSize: 16),
            ),
            DropDownButtonCustom(
              value: fontNormal,
              item: fontSizeConfig,
              title: "Chọn cỡ chữ",
              onChange: (value) {
                setState(() {
                  fontNormal = value;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Màu chữ thường",
              style: TextStyle(fontSize: 16),
            ),
            PickerColorButton(
                currentColor: colorNormal ?? Colors.transparent,
                onChange: changeColorNormal)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cỡ chữ sub",
              style: TextStyle(fontSize: 16),
            ),
            DropDownButtonCustom(
              value: fontSub,
              item: fontSizeConfig,
              title: "Chọn cỡ chữ",
              onChange: (value) {
                setState(() {
                  fontSub = value;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Màu chữ sub",
              style: TextStyle(fontSize: 16),
            ),
            PickerColorButton(
                currentColor: colorSub ?? Colors.transparent,
                onChange: changeColorSub)
          ],
        ),
      ],
    );
  }
}
