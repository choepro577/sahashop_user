import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/pickerColorButton.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:sahashop_user/app_user/utils/color.dart';

class MainConfigThemeColor extends StatefulWidget {
  @override
  _MainConfigThemeColorState createState() => _MainConfigThemeColorState();
}

class _MainConfigThemeColorState extends State<MainConfigThemeColor> {
  Map<String, dynamic>? value;

  Color? colorButton;

  changeColor(Color color) {
    setState(() => colorButton = color);
    controller.configApp.colorMain1 = color.toHex();
  }

  final ConfigController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                HexColor(controller.configApp.colorMain1!),
            onChange: changeColor)
      ],
    );
  }
}
