import 'package:hive/hive.dart';
import 'package:sahashop_user/model/product.dart';
part 'order.g.dart';

@HiveType(typeId: 0)
class Order {
  @HiveField(0)
  final int quantity;

  @HiveField(1)
  final Product product;

  Order({this.product, this.quantity});
}
