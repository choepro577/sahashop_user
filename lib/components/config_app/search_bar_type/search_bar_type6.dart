import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter_type3.dart';

class SearchBarType6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
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
        IconBtnWithCounterType3(
          svgSrc: "assets/icons/cart_icon.svg",
          press: () {},
        ),
        IconBtnWithCounterType3(
          svgSrc: "assets/icons/wallet.svg",
          numOfitem: 3,
          press: () {},
        ),
      ],
    );
  }
}
