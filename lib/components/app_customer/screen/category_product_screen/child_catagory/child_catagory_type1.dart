import 'package:flutter/cupertino.dart';
import 'package:sahashop_user/components/saha_user/customCard/product_card_exam.dart';
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
                return ProductCardExam(product: demoProducts[index]);
              return SizedBox.shrink(); // here by default width and height is 0
            },
          ),
          ProductCardExam(product: demoProducts[2]),
          ProductCardExam(product: demoProducts[3]),
        ],
      ),
    );
  }
}
