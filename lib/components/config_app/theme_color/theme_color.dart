import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/pickerColorButton.dart';
import 'package:sahashop_user/utils/color.dart';

import '../../../screen/config_app/config_controller.dart';

class MainConfigThemeColor extends StatefulWidget {
  @override
  _MainConfigThemeColorState createState() => _MainConfigThemeColorState();
}

class _MainConfigThemeColorState extends State<MainConfigThemeColor> {
  Map<String, dynamic> value;

  Color colorButton;

  changeColor(Color color) {
    setState(() => colorButton = color);
    controller.configApp.colorMain1 = color.toHex();
  }

  ConfigController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Theme Color",
          style: TextStyle(fontSize: 17),
        ),
        PickerColorButton(
            currentColor:
                colorButton ?? HexColor(controller.configApp.colorMain1),
            onChange: changeColor)
      ],
    );
  }
}
