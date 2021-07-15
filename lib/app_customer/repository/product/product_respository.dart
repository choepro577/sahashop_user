import 'package:sahashop_user/app_customer/remote/response-request/favorite/all_product_response.dart';
import 'package:sahashop_user/app_customer/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_user/app_customer/remote/response-request/product/product_watched_response.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/example/product.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/product/detail_product_response.dart';
import '../../repository/handle_error.dart';
import '../../utils/thread_data.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class ProductCustomerRepository {
  Future<List<Product>?> searchProduct(
      {String search = "",
      int page = 1,
      String idCategory = "",
      bool descending = false,
      String details = "",
      String sortBy = ""}) async {
    if (FlowData().isOnline()) {
      try {
        var res = await CustomerServiceManager().service!.searchProduct(
            UserInfo().getCurrentStoreCode(),
            page,
            search,
            idCategory,
            descending,
            details,
            sortBy);
        return res.data!.data;
      } catch (err) {
        handleErrorCustomer(err);
      }
    } else {
      return EXAMPLE_LIST_PRODUCT;
    }
  }

  Future<DetailProductResponse?> getDetailProduct(int? idProduct) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getDetailProduct(UserInfo().getCurrentStoreCode(), idProduct);
      return res;
    } catch (err) {
      // SahaAlert.showError(message: err.toString());
    }
  }

  Future<AllProductFavorites?> getAllPurchasedProducts({int? page}) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getPurchasedProducts(UserInfo().getCurrentStoreCode()!, page!);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<AllProductResponse?> getSimilarProduct(int idProduct) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getSimilarProduct(UserInfo().getCurrentStoreCode()!, idProduct);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<ProductWatchedResponse?> getWatchedProduct() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getWatchedProduct(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
