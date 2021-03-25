import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/screen/config_app/config_screen.dart';
import 'package:sahashop_user/screen/home/component_home/section_title.dart';
import 'package:sahashop_user/screen/inventory/inventory_screen.dart';

class Categories extends StatelessWidget {

  final List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/flash_icon.svg", "text": "Chỉnh sửa mặt hàng"},
    {"icon": "assets/icons/bill_icon.svg", "text": "Bill"},
    {"icon": "assets/icons/gameicon.svg", "text": "Game"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/discover.svg", "text": "More"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Padding(
        padding: EdgeInsets.all(20),
        child: SectionTitle(
          title: "Cài đặt cửa hàng",
          press: () {},
        ),
      ),
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryCard(
                  icon: 'assets/icons/flash_icon.svg',
                  text: 'Chỉnh sửa mặt hàng',
                  press: () {
                    Get.to(InventoryScreen());
                  },
                ),
                CategoryCard(
                  icon: 'assets/icons/gift_icon.svg',
                  text: 'Chỉnh sửa giao diện',
                  press: () {
                    Get.to(ConfigScreen());
                  },
                ),
              ]
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      colors: [SahaPrimaryColor, SahaPrimaryLightColor],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: SvgPicture.asset(icon, color: Colors.white,),
              ),
              SizedBox(height: 5),
              Text(text, textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}