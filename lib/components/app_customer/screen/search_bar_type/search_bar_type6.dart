import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter_type3.dart';

class SearchBarType6 extends StatelessWidget {
  final Function onSearch;

  const SearchBarType6({Key key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29.5),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.16),
                  spreadRadius: -2,
                )
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                icon: SvgPicture.asset("assets/icons/search.svg"),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            IconBtnWithCounterType3(
              svgSrc: "assets/icons/cart_icon.svg",
              press: () {},
            ),
            SizedBox(
              width: 10,
            ),
            IconBtnWithCounterType3(
              svgSrc: "assets/icons/wallet.svg",
              numOfitem: 3,
              press: () {},
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
