
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
    {"icon": "assets/icons/bill_icon.svg", "text": "Đơn hàng", "numOfitem": 40},
    {"icon": "assets/icons/gift_icon.svg", "text": "Các ưu đãi"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
    // {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
    // {"icon": "assets/icons/gift_icon.svg", "text": "Daily Gift"},
    // {"icon": "assets/icons/discover.svg", "text": "More"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ],
    );
  }
}


