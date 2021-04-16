import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card.dart';
import 'package:sahashop_user/model/product2222.dart';

class ChildCategoryType1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          ...List.generate(
            demoProducts.length,
            (index) {
              if (demoProducts[index].isPopular)
                return ProductCard(product: demoProducts[index]);
              return SizedBox.shrink(); // here by default width and height is 0
            },
          ),
          ProductCard(product: demoProducts[2]),
          ProductCard(product: demoProducts[3]),
        ],
      ),
    );
  }
}
