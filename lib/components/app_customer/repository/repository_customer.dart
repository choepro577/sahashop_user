import 'package:sahashop_user/components/app_customer/repository/address_repository/address_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/cart/cart_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/category/category_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/chat_customer/chat_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/config_app/config_ui_respository.dart';
import 'package:sahashop_user/components/app_customer/repository/info_customer/info_customer_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/login/login_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/marketing_chanel/marketing_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/orders/order_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/payment/payment_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/product/product_respository.dart';
import 'package:sahashop_user/components/app_customer/repository/register/register_repository.dart';
import 'package:sahashop_user/components/app_customer/repository/shipment/shipment_repository.dart';
import 'package:sahashop_user/data/repository/post/post_repository.dart';

import 'favorite/favorite_repository.dart';
import 'history_search/history_search_repository.dart';
import 'home/home_repository.dart';
import 'post/post_repository.dart';

class CustomerRepositoryManager {
  static CategoryRepository get categoryRepository => CategoryRepository();
  static FavoriteRepository get favoriteRepository => FavoriteRepository();
  static ConfigUICustomerRepository get configUiRepository =>
      ConfigUICustomerRepository();
  static ProductCustomerRepository get productCustomerRepository =>
      ProductCustomerRepository();
  static OrderCustomerRepository get orderCustomerRepository =>
      OrderCustomerRepository();
  static HomeDataRepository get homeDataCustomerRepository =>
      HomeDataRepository();
  static PostCustomerRepository get postCustomerRepository =>
      PostCustomerRepository();
  static RegisterCustomerRepository get registerCustomerRepository =>
      RegisterCustomerRepository();
  static LoginCustomerRepository get loginCustomerRepository =>
      LoginCustomerRepository();
  static InfoCustomerRepository get infoCustomerRepository =>
      InfoCustomerRepository();
  static ChatCustomerRepository get chatCustomerRepository =>
      ChatCustomerRepository();
  static MarketingRepository get marketingRepository => MarketingRepository();
  static CartRepository get cartRepository => CartRepository();
  static AddressRepository get addressRepository => AddressRepository();
  static ShipmentRepository get shipmentRepository => ShipmentRepository();
  static PaymentRepository get paymentRepository => PaymentRepository();
  static HistorySearchRepository get historySearchRepository => HistorySearchRepository();
}
