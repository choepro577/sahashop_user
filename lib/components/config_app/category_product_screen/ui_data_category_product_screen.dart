import 'package:flutter/material.dart';

import 'child_catagory/child_catagory_type1.dart';

var uiDataCategoryProduct = [
  ParentCategory(name: "PS4", icon: "config.svg", listChildConfig: [
    ChildCategory(name: "Kiểu chữ", editWidget: ChildCategoryType1()),
  ]),
  ParentCategory(name: "PS4", icon: "config.svg", listChildConfig: [
    ChildCategory(name: "Kiểu chữ", editWidget: ChildCategoryType1()),
  ]),
  ParentCategory(name: "PS4", icon: "config.svg", listChildConfig: [
    ChildCategory(name: "Kiểu chữ", editWidget: ChildCategoryType1()),
  ]),
  ParentCategory(name: "PS4", icon: "config.svg", listChildConfig: [
    ChildCategory(name: "Kiểu chữ", editWidget: ChildCategoryType1()),
  ]),
  ParentCategory(name: "PS4", icon: "config.svg", listChildConfig: [
    ChildCategory(name: "Kiểu chữ", editWidget: ChildCategoryType1()),
  ]),
  ParentCategory(name: "PS4", icon: "config.svg", listChildConfig: [
    ChildCategory(name: "Kiểu chữ", editWidget: ChildCategoryType1()),
  ]),
];

class ParentCategory {
  String name;
  String icon;
  List<ChildCategory> listChildConfig;

  ParentCategory({this.name, this.listChildConfig, this.icon});
}

class ChildCategory {
  String name;
  Widget editWidget;

  ChildCategory({this.name, this.editWidget});
}
