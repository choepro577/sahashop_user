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
}