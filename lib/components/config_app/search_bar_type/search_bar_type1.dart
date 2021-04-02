import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/config_app/search_bar_type/handle_search_bar.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';

class SearchBarType1 extends StatelessWidget {
  final Function onSearch;

  const SearchBarType1({Key key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: SearchField(
            onSearch: (text) {
              HandleSearchBar.onSearch(text);
            },
          ),
        ),
        Flexible(
          flex: 4,
          child: Row(
            children: [
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
          ),
        )
      ],
    );
  }
}
