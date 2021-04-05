import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';

import 'handle_search_bar.dart';

class SearchBarType2 extends StatelessWidget {
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
          child: SearchField(
            onSearch: (text) {
              HandleSearchBar.onSearch(text);
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Row(
          children: [
            IconBtnWithCounter(
              svgSrc: "assets/icons/cart_icon.svg",
              press: () {},
            ),
            SizedBox(
              width: 10,
            ),
            IconBtnWithCounter(
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
