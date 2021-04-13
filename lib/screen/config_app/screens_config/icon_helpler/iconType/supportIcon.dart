import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/pickerColorButton.dart';

import '../../../../../const/constant.dart';
import '../../../config_controller.dart';

class SupportIcon extends StatefulWidget {
  @override
  _SupportIconState createState() => _SupportIconState();
}

class _SupportIconState extends State<SupportIcon> {
  final ConfigController controller = Get.find();

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
              color: Theme.of(context).primaryColor,
            ),
            Checkbox(
              tristate: false,
              value: controller.configApp.isShowIconHotline,
              onChanged: (bool choose) {
                setState(() {
                  controller.configApp.isShowIconHotline = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
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
              "- Số điện thoại :",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: controller.configApp.phoneNumberHotline ?? "",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.configApp.phoneNumberHotline = value;
                },
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
              color: Theme.of(context).primaryColor,
            ),
            Checkbox(
              tristate: false,
              value: controller.configApp.isShowIconEmail,
              onChanged: (bool choose) {
                setState(() {
                  controller.configApp.isShowIconEmail = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
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
              "- Email :",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: controller.configApp.contactEmail ?? "",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.configApp.contactEmail = value;
                },
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
              value: controller.configApp.isShowIconFacebook,
              onChanged: (bool choose) {
                setState(() {
                  controller.configApp.isShowIconFacebook = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
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
                decoration: InputDecoration(
                  hintText: controller.configApp.idFacebook ?? "",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.configApp.idFacebook = value;
                },
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
              value: controller.configApp.isShowIconZalo,
              onChanged: (bool choose) {
                setState(() {
                  controller.configApp.isShowIconZalo = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
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
                decoration: InputDecoration(
                  hintText: controller.configApp.idZalo ?? "",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.configApp.idZalo = value;
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
