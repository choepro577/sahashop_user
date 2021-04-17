import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/screen/home/widget/catagorys.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/add_product_controller.dart';
import 'package:smart_select/smart_select.dart';

import 'search_controller.dart';

class SearchScreen extends StatefulWidget {
  String searchText;

  SearchScreen({this.searchText});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchEditingController = TextEditingController();
  Map<String, String> chooseDropDownValue;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> descendingFilter = [
    {"Phổ biến ": "sss"},
    {"Bán chạy ": "sss"},
    {"Hàng mới ": "sss"},
    {"Giá tăng dần ": "sss"},
    {"Giá giảm dần ": "sss"},
  ];

  List<String> _car = [];
  List<String> _smartphone = [];
  List<String> _day = ['fri'];

  @override
  void initState() {
    // TODO: implement initState
    searchEditingController.text = widget.searchText;
    chooseDropDownValue = descendingFilter[0];
  }

  SearchController searchController = new SearchController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryTextTheme.headline1.color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  autofocus: true,
                  controller: searchEditingController,
                  onChanged: (value) => print(value),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search product",
                      prefixIcon: Icon(
                        Icons.search,
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconBtnWithCounter(
              svgSrc: "assets/icons/cart_icon.svg",
              numOfitem: 1,
              press: () {},
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      body: Scaffold(
        key: scaffoldKey,
        endDrawer: Container(
          width: Get.width * 0.7,
          child: Drawer(
            child: SingleChildScrollView(
              child: Obx(
                () => searchController.isLoadingCategory.value
                    ? SahaLoadingWidget()
                    : Column(
                        children: <Widget>[
                          const SizedBox(height: 7),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Danh mục sản phẩm"),
                          ),
                          Container(
                            height: 100,
                            child: Wrap(
                              children: [
                                ...List.generate(
                                  searchController.listCategory.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FilterChip(
                                      label: Text(searchController
                                          .listCategory[index].name),
                                      selected: searchController
                                          .listSelected[index].values.first,
                                      backgroundColor: Colors.transparent,
                                      shape: StadiumBorder(side: BorderSide()),
                                      onSelected: (bool value) {
                                        setState(() {
                                          searchController.listSelected[index]
                                              .update(
                                                  searchController
                                                      .listSelected[index]
                                                      .keys
                                                      .first,
                                                  (value) => !searchController
                                                      .listSelected[index]
                                                      .values
                                                      .first);
                                          print(searchController
                                              .listSelected[index]
                                              .values
                                              .first);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(indent: 20),
                        ],
                      ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text("Sắp xếp : "),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton<Map<String, String>>(
                          focusColor: Colors.white,
                          value: chooseDropDownValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: descendingFilter
                              .map<DropdownMenuItem<Map<String, String>>>(
                                  (Map<String, String> value) {
                            return DropdownMenuItem<Map<String, String>>(
                              value: value,
                              child: Text(
                                "${value.keys.first}",
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (Map<String, String> value) {
                            setState(() {
                              chooseDropDownValue = value;
                              // _chosenValue = value.keys.first;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.filter_alt_outlined),
                      onPressed: () {
                        scaffoldKey.currentState.openEndDrawer();
                        searchController.getAllCategory();
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
