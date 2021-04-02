import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter_type2.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';

class SearchBarType3 extends StatelessWidget {
  final Function onSearch;

  const SearchBarType3({Key key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFF3E4067),
              ),
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
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: "Search your destination…",
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF464A7E),
                ),
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ),
        Flexible(
            flex: 4,
            child: Row(
              children: [
                IconBtnWithCounterType2(
                  svgSrc: "assets/icons/cart_icon.svg",
                  press: () {},
                ),
                IconBtnWithCounterType2(
                  svgSrc: "assets/icons/bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ))
      ],
    );
  }
}
