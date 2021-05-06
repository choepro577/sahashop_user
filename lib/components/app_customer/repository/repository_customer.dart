import 'package:sahashop_user/components/app_customer/repository/category/category_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/config_app/config_ui_respository.dart';
import 'package:sahashop_user/components/app_customer/repository/orders/order_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/product/product_respository.dart';

import 'home/home_repository.dart';

class CustomerRepositoryManager {
  static CategoryRepository get categoryRepository => CategoryRepository();
  static ConfigUICustomerRepository get configUiRepository =>
      ConfigUICustomerRepository();
  static ProductCustomerRepository get productCustomerRepository =>
      ProductCustomerRepository();
  static OrderCustomerRepository get createOrderCustomerRepository =>
      OrderCustomerRepository();
  static HomeDataRepository get homeDataCustomerRepository =>
      HomeDataRepository();
}
