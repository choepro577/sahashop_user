import 'package:flutter/material.dart';
import 'package:sahashop_user/model/product.dart';

class Cart {
  final Product product;
  final int numOfItem;

  Cart({@required this.product, @required this.numOfItem});
}

