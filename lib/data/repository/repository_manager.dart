import 'package:sahashop_user/data/repository/address/address_repository.dart';
import 'package:sahashop_user/data/repository/chat/chat_repository.dart';
import 'package:sahashop_user/data/repository/product/product_repository.dart';
import 'package:sahashop_user/data/repository/register/register_repository.dart';
import 'package:sahashop_user/data/repository/type_of_shop/type_of_shop_repository.dart';

import 'category/category_repository.dart';
import 'config_ui/config_ui_repository.dart';
import 'device_token/device_token_repository.dart';
import 'image/image_repository.dart';
import 'login/login_repository.dart';
import 'marketing_chanel/marketing_chanel_repository.dart';
import 'post/post_repository.dart';
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
  static ImageRepository get imageRepository => ImageRepository();
  static DeviceTokenRepository get deviceTokenRepository =>
      DeviceTokenRepository();
  static MarketingChanelRepository get marketingChanel =>
      MarketingChanelRepository();
  static PostRepository get postRepository => PostRepository();
  static AddressRepository get addressRepository => AddressRepository();
  static ChatRepository get chatRepository => ChatRepository();
}
