import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'search_controller.dart';

class SearchScreen extends StatefulWidget {
  String searchText;

  SearchScreen({this.searchText});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchEditingController = TextEditingController();

  bool descending = false;
  String sortBy = "price";
  Map<String, bool> chooseDropDownValue;
  Map<String, String> chooseDropDownSortValue;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, bool>> descendingFilter = [
    {"Tăng dần ": false},
    {"Giảm dần ": true},
  ];

  List<Map<String, String>> sortFilter = [
    {"Giá ": "price"},
    {"Phổ biến ": "waiting backend"},
    {"Bán chạy ": "waiting backend"},
    {"Hàng mới ": "waiting backend"},
  ];

  bool chooseXS = false,
      chooseS = false,
      chooseM = false,
      chooseL = false,
      chooseXL = false,
      chooseXXL = false;
  String XS = "";
  String S = "";
  String M = "";
  String L = "";
  String XL = "";
  String XXL = "";

  @override
  void initState() {
    // TODO: implement initState
    searchEditingController.text = widget.searchText;
    chooseDropDownValue = descendingFilter[0];
    chooseDropDownSortValue = sortFilter[0];
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
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    searchController.searchProduct(
                        searchEditingController.text, descending, sortBy);
                  },
                  autofocus: true,
                  controller: searchEditingController,
                  //onChanged: (value) => print(value),
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
          width: Get.width * 0.8,
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
                          Wrap(
                            children: [
                              ...List.generate(
                                searchController.listCategory.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FilterChip(
                                    label: Text(searchController
                                        .listCategory[index].name),
                                    selected: searchController
                                        .listCategorySelected[index]
                                        .values
                                        .first,
                                    backgroundColor: Colors.transparent,
                                    shape: StadiumBorder(side: BorderSide()),
                                    onSelected: (bool value) {
                                      setState(() {
                                        searchController
                                            .listCategorySelected[index]
                                            .update(
                                                searchController
                                                    .listCategorySelected[index]
                                                    .keys
                                                    .first,
                                                (value) => !searchController
                                                    .listCategorySelected[index]
                                                    .values
                                                    .first);
                                        print(searchController
                                            .listCategorySelected[index]
                                            .values
                                            .first);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(indent: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Size"),
                          ),
                          Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text("XS"),
                                  selected: chooseXS,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    if (chooseXS == false) {
                                      XS = "XS";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseXS = true;
                                        print(chooseXS);
                                      });
                                    } else {
                                      XS = "";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseXS = false;
                                        print(chooseXS);
                                      });
                                    }
                                    print(searchController.sizeSearch);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text("S"),
                                  selected: chooseS,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    if (chooseS == false) {
                                      S = "S";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseS = true;
                                        print(chooseS);
                                      });
                                    } else {
                                      S = "";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseS = false;
                                        print(chooseS);
                                      });
                                    }
                                    print(searchController.sizeSearch);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text("M"),
                                  selected: chooseM,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    if (chooseM == false) {
                                      M = "M";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseM = true;
                                        print(chooseM);
                                      });
                                    } else {
                                      M = "";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseM = false;
                                        print(chooseM);
                                      });
                                    }
                                    print(searchController.sizeSearch);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text("L"),
                                  selected: chooseL,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    if (chooseL == false) {
                                      L = "L";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseL = true;
                                        print(chooseL);
                                      });
                                    } else {
                                      L = "";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseL = false;
                                        print(chooseL);
                                      });
                                    }
                                    print(searchController.sizeSearch);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text("XL"),
                                  selected: chooseXL,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    if (chooseXL == false) {
                                      XL = "XL";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseXL = true;
                                        print(chooseXL);
                                      });
                                    } else {
                                      XL = "";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseXL = false;
                                        print(chooseXL);
                                      });
                                    }
                                    print(searchController.sizeSearch);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text("XXL"),
                                  selected: chooseXXL,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    if (chooseXXL == false) {
                                      XXL = "XXL";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseXXL = true;
                                        print(chooseXXL);
                                      });
                                    } else {
                                      XXL = "";
                                      setState(() {
                                        searchController.sizeSearch = "Size:" +
                                            XS +
                                            "," +
                                            S +
                                            "," +
                                            M +
                                            "," +
                                            L +
                                            "," +
                                            XL +
                                            "," +
                                            XXL;
                                        chooseXXL = false;
                                        print(chooseXXL);
                                      });
                                    }
                                    print(searchController.sizeSearch);
                                  },
                                ),
                              ),
                            ],
                          ),
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
                          value: chooseDropDownSortValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: sortFilter
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
                              chooseDropDownSortValue = value;
                              sortBy = value.values.first;
                              print(sortBy);
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton<Map<String, bool>>(
                          focusColor: Colors.white,
                          value: chooseDropDownValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: descendingFilter
                              .map<DropdownMenuItem<Map<String, bool>>>(
                                  (Map<String, bool> value) {
                            return DropdownMenuItem<Map<String, bool>>(
                              value: value,
                              child: Text(
                                "${value.keys.first}",
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (Map<String, bool> value) {
                            setState(() {
                              chooseDropDownValue = value;
                              descending = value.values.first;
                              print(descending);
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
            ),
            Obx(
              () => searchController.isLoadingProduct.value
                  ? SahaLoadingWidget()
                  : Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        children: [
                          ...List.generate(
                              searchController.listProduct.length,
                              (index) => ProductCard(
                                  product: searchController.listProduct[index],
                                  press: () {}))
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
