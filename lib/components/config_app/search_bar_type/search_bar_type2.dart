import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';

class SearchBarType2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 7, child: SearchField()),
        Flexible(
            flex: 4,
            child: Row(
              children: [
                IconBtnWithCounter(
                  svgSrc: "assets/icons/cart_icon.svg",
                  numOfitem: 1,
                  press: () {},
                ),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/wallet.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ))
      ],
    );
  }
}
