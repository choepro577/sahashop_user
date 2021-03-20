import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';
import 'package:sahashop_user/screen/config_app/config_screen.dart';

import 'component_home/catagorys.dart';
import 'component_home/funtionList.dart';
import 'component_home/popular_products.dart';
import 'component_home/special_offers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var selectedItem = 0;
  List screen = [
    Home(),
    ConfigScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 55,
          backgroundColor: Colors.transparent,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.settings, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (currentIndex) {
            setState(() {
              selectedItem = currentIndex;
            });
          },
        ),
        body: screen[selectedItem]
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FuntionListSale(),
          Categories(),
          SpecialOffers(),
          PopularProducts(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}



