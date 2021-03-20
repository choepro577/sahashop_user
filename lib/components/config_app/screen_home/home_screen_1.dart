import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahashop_user/components/config_app/screen_home/base/home_sreen_base.dart';
import 'package:sahashop_user/model/button.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';


class HomeScreenStyle1 extends StatelessWidget implements HomeScreenBase {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index].icon,
              text: categories[index].name,
              press: () {},
            ),
          ),
        ),
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

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 55,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon),
              ),
              SizedBox(height: 5),
              Text(text, textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
