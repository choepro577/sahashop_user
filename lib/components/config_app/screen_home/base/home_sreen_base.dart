import 'package:sahashop_user/model/button.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/model/product.dart';

abstract class HomeScreenBase {
  final List<Category> categories;
  final List<ButtonConfig> buttonConfigs;
  final Function(Product) onPressedProduct;
  final Function(Product) onPressedCategories;
  final Function(Product) onPressedButtonConfig;

  HomeScreenBase(
      {this.buttonConfigs,
      this.onPressedProduct,
      this.onPressedCategories,
      this.onPressedButtonConfig,
      this.categories});
}
