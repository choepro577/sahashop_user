import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/components/saha_user/button/saha_box_button.dart';
import 'package:sahashop_user/const/constant.dart';
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

          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                categories.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {},
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
                                          colors: [
                                            SahaPrimaryColor,
                                            SahaPrimaryLightColor
                                          ],
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(0.5, 0.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    child: SvgPicture.asset(
                                      categories[index]["icon"],
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        categories[index]["text"],
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (categories[index]["numOfitem"] != null &&
                                categories[index]["numOfitem"] != 0)
                              Positioned(
                                top: -1,
                                right: 5,
                                child: Container(
                                  height: 17,
                                  width: 17,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF4848),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1.5, color: Colors.white),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${categories[index]["numOfitem"]}",
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
                    )
                //     SahaBoxButton(
                //   icon: categories[index]["icon"],
                //   text: categories[index]["text"],
                //   numOfitem: categories[index]["numOfitem"],
                //   press: () {},
                // ),
                ),
          ),
        ),
      ],
    );
  }
}
