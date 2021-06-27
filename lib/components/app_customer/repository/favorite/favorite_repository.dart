import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/favorite/all_product_response.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/utils/user_info.dart';

class FavoriteRepository {
  Future<AllProductFavorites?> getAllFavorite({int? page}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllFavorite(UserInfo().getCurrentStoreCode()!,page!);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> favoriteProduct(int productId, bool isFavorite) async {
    try {
      var res = await CustomerServiceManager().service!.favoriteProduct(
          UserInfo().getCurrentStoreCode()!,
          productId,
          {"is_favorite": isFavorite});
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      throw (err.toString());
      return false;
    }
  }
}
