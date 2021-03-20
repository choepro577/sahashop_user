import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListCategoryType2 extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/flash_icon.svg", "text": "Flash Deal"},
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              press: () {},
            ),
          ),
        ),
      ),
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
          width: 55,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon),
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
