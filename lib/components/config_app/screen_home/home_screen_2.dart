import 'package:flutter/material.dart';
import 'package:sahashop_user/components/config_app/screen_home/base/home_sreen_base.dart';
import 'package:sahashop_user/model/button.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

class HomeScreenStyle2 extends StatelessWidget implements HomeScreenBase {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Container(
            height: 52,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index) =>
                    Text("fgfdgdf")
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement buttonConfigs
  List<ButtonConfig> get buttonConfigs => throw UnimplementedError();

  @override
  // TODO: implement categories
  List<Category> get categories => throw UnimplementedError();

  @override
  // TODO: implement onPressedButtonConfig
  Function(Product p1) get onPressedButtonConfig => throw UnimplementedError();

  @override
  // TODO: implement onPressedCategories
  Function(Product p1) get onPressedCategories => throw UnimplementedError();

  @override
  // TODO: implement onPressedProduct
  Function(Product p1) get onPressedProduct => throw UnimplementedError();

}