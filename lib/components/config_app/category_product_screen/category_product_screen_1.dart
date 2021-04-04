import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sahashop_user/components/config_app/category_product_screen/ui_data_category_product_screen.dart';
import 'package:sahashop_user/components/saha_user/iconButton/iconbtn_counter.dart';

import '../../../const/constant.dart';

class CategoryProductStyle1 extends StatefulWidget {
  // final List<Product> products;
  // final List<Cate>

  @override
  _CategoryProductStyle1State createState() => _CategoryProductStyle1State();
}

class _CategoryProductStyle1State extends State<CategoryProductStyle1> {
  var indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: SahaSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) => print(value),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search product",
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            IconBtnWithCounter(
              svgSrc: "assets/icons/cart_icon.svg",
              numOfitem: 1,
              press: () {},
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Container(
            width: 70,
            color: Colors.grey[200],
            child: ListView.builder(
                itemCount: uiDataCategoryProduct.length,
                itemBuilder: (context, index) {
                  return buildItem(index: index);
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.black12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          uiDataCategoryProduct[indexSelected].name,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  uiDataCategoryProduct[indexSelected].listChildConfig ==
                              null ||
                          uiDataCategoryProduct[indexSelected]
                                  .listChildConfig
                                  .length ==
                              0
                      ? Container(
                          height: 5,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: uiDataCategoryProduct[indexSelected]
                              .listChildConfig
                              .map(
                                (e) => e.editWidget == null
                                    ? Container()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          e.editWidget
                                        ],
                                      ),
                              )
                              .toList(),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem({int index}) {
    ParentCategory parentCategory = uiDataCategoryProduct[index];
    return Container(
      color: indexSelected == index ? Colors.white : Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            indexSelected = index;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                "assets/icons/${parentCategory.icon}",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              parentCategory.name,
              style: TextStyle(
                  fontSize: 14,
                  color: indexSelected == index ? bmColors : Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
