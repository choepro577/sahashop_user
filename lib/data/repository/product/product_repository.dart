import 'package:sahashop_user/data/remote/response/product/product_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

import '../handle_error.dart';

class ProductRepository {
  Future<Product> create(Product productRequest) async {
    try {
      var res = await SahaServiceManager().service.createProduct(
          UserInfo().getCurrentStoreCode(), productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Product>> getAllProduct() async {
    try {
      var res = await SahaServiceManager()
          .service
          .getAllProduct(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
