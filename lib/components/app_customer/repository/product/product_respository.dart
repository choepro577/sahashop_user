import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/product/detail_product_response.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/components/app_customer/utils/thread_data.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

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
      return LIST_PRODUCT_EXAMPLE;
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
}
