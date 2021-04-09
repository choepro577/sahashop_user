import 'package:flutter/material.dart';
import 'package:sahashop_user/components/saha_user/custom_fonts/custom_font.dart';

import '../../../const/constant.dart';

class MainConfigLogo extends StatefulWidget {
  @override
  _MainConfigLogoState createState() => _MainConfigLogoState();
}

class _MainConfigLogoState extends State<MainConfigLogo> {
  bool isShowHotline = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Thêm Logo",
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: "baloo_regular",
                    fontSize: 30)),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {},
              color: bmColors,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hiện logo",
              style: TextStyle(fontSize: 16),
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
      ],
    );
  }
}
