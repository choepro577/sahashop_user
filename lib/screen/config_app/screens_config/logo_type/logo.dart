import 'package:flutter/material.dart';
import 'package:sahashop_user/screen/config_app/screens_config/logo_type/select_logo_image.dart';

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
            Text(
              "Thêm Logo",
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
            SelectLogoImage(
              onChange: (file) {},
            )
          ],
        ),
      ],
    );
  }
}
