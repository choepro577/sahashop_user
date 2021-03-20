import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const/constant.dart';

class BannerType1 extends StatefulWidget {
  @override
  _BannerType1State createState() => _BannerType1State();
}

class _BannerType1State extends State<BannerType1> {
  List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/flash_icon.svg", "text": "Flash Deal"},
    {"icon": "assets/icons/bill_icon.svg", "text": "Bill"},
    {"icon": "assets/icons/gameicon.svg", "text": "Game"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 180,
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: SizedBox(
                    child: SvgPicture.asset(
                      "assets/icons/qr-code.svg",
                    ),
                    width: MediaQuery.of(context).size.width / 12,
                    height: MediaQuery.of(context).size.width / 12,
                  ),
                  onTap: () {},
                ),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width / 10,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Hiếu",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "0 VND",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => FuntionCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FuntionCard extends StatelessWidget {
  const FuntionCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 80,
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
    );
  }
}
