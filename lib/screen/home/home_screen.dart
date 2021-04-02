import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/search/seach_field.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/screen/config_app/config_screen.dart';
import 'package:sahashop_user/screen/home/home_controller.dart';

import 'widget/catagorys.dart';
import 'widget/head_home.dart';
import 'widget/popular_products.dart';
import 'widget/special_offers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedItem = 0;

  final HomeController homeController = Get.put(HomeController());

  List screen = [
    Home(),
    ConfigScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
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
              body: screen[selectedItem]),

            Obx(
                    () => homeController.isLoadingStore.value
                    ? SahaLoadingFullScreen() : Container()
            ),
        ],
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
          HeadHome(),
          Stack(
            children: [
              Column(
                children: [
                  Categories(),
                  SpecialOffers(),
                  PopularProducts(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
