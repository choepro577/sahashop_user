import 'package:flutter/material.dart';

class CategoryProductStyle2 extends StatelessWidget {
  // final List<Product> products;
  // final List<Cate>

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
                itemBuilder: (context, index) => Text("fgfdgdf")),
          )
        ],
      ),
    );
  }
}
