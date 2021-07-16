import 'package:sahashop_user/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/favorite/all_product_response.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';

class FavoriteRepository {
  Future<AllProductFavorites?> getAllFavorite({int? page}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllFavorite(StoreInfo().getCustomerStoreCode()!, page!);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> favoriteProduct(int productId, bool isFavorite) async {
    try {
      var res = await CustomerServiceManager().service!.favoriteProduct(
          StoreInfo().getCustomerStoreCode()!,
          productId,
          {"is_favorite": isFavorite});
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      throw (err.toString());
    }
  }
}
