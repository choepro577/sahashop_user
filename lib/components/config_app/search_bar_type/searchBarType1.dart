import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';

class SearchBarType1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchField(),
        IconBtnWithCounter(
          svgSrc: "assets/icons/cart_icon.svg",
          press: () {},
        ),
        IconBtnWithCounter(
          svgSrc: "assets/icons/bell.svg",
          numOfitem: 3,
          press: () {},
        ),
      ],
    );
  }
}
