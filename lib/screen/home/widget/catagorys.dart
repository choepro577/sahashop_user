import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/screen/home/widget/section_title.dart';

class Categories extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/bill_icon.svg", "text": "Bill"},
    {"icon": "assets/icons/gift_icon.svg", "text": "Game"},
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
      children: [
        Padding(
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
              (index) => SahaBoxButton(
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
