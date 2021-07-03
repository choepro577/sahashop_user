import '../repository/address_repository/address_repository.dart';
import '../repository/cart/cart_repository.dart';
import '../repository/category/category_repository.dart';
import '../repository/chat_customer/chat_repository.dart';
import '../repository/config_app/config_ui_respository.dart';
import '../repository/info_customer/info_customer_repository.dart';
import '../repository/login/login_repository.dart';
import '../repository/marketing_chanel/marketing_repository.dart';
import '../repository/orders/order_repository.dart';
import '../repository/payment/payment_repository.dart';
import '../repository/product/product_respository.dart';
import '../repository/register/register_repository.dart';
import '../repository/review/review_repository.dart';
import '../repository/shipment/shipment_repository.dart';

import 'badge/badge_repository.dart';
import 'favorite/favorite_repository.dart';
import 'history_search/history_search_repository.dart';
import 'home/home_repository.dart';
import 'post/post_repository.dart';
import 'score/score_repository.dart';

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
  static HistorySearchRepository get historySearchRepository =>
      HistorySearchRepository();
  static ReviewCustomerRepository get reviewCustomerRepository =>
      ReviewCustomerRepository();
  static BadgeRepository get badgeRepository => BadgeRepository();
  static ScoreRepository get scoreRepository => ScoreRepository();
}
