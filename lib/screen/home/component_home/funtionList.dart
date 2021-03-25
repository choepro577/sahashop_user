import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const/constant.dart';

class FuntionListSale extends StatefulWidget {
  @override
  _FuntionListSaleState createState() => _FuntionListSaleState();
}

class _FuntionListSaleState extends State<FuntionListSale> {
  List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/flash_icon.svg", "text": "Báo cáo"},
    {"icon": "assets/icons/bill_icon.svg", "text": "Đơn hàng" , "numOfitem": 40},
    {"icon": "assets/icons/gift_icon.svg", "text": "Các ưu đãi"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
    // {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
    // {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: SahaBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(9))),
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
                            "Hiếu Store",
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
      ),
    );
  }
}

class FuntionCard extends StatelessWidget {
  const FuntionCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press, this.numOfitem,
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
