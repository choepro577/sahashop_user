import 'package:sahashop_user/data/repository/product/product_repository.dart';
import 'package:sahashop_user/data/repository/register/register_repository.dart';
import 'package:sahashop_user/data/repository/type_of_shop/type_of_shop_repository.dart';

import 'category/category_repository.dart';
import 'config_ui/config_ui_repository.dart';
import 'login/login_repository.dart';
import 'store/store_repository.dart';

class RepositoryManager {
  static ProductRepository get productRepository => ProductRepository();
  static RegisterRepository get registerRepository => RegisterRepository();
  static StoreRepository get storeRepository => StoreRepository();
  static LoginRepository get loginRepository => LoginRepository();
  static TypeOfShopRepository get typeOfShopRepository =>
      TypeOfShopRepository();
  static CategoryRepository get categoryRepository => CategoryRepository();
  static ConfigUIRepository get configUiRepository => ConfigUIRepository();
}
