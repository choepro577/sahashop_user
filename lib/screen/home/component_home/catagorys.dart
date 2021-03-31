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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
                  (index) => FuntionCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                numOfitem: categories[index]["numOfitem"],
                press: () {},
              ),
            ),
          ),
        ),

      ],
    );
  }
}

class FuntionCard extends StatelessWidget {
  const FuntionCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
    this.numOfitem,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;
  final int numOfitem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            SizedBox(
              width: 80,
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
                    child: SvgPicture.asset(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (numOfitem != null && numOfitem != 0)
              Positioned(
                top: -1,
                right: 5,
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF4848),
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "$numOfitem",
                      style: TextStyle(
                        fontSize: 10,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

