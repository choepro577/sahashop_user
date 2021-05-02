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

  Future<List<Product>> getAllProduct(
      {String search,
      String idCategory,
      bool descending,
      String details,
      String sortBy}) async {
    try {
      var res = await SahaServiceManager().service.getAllProduct(
          UserInfo().getCurrentStoreCode(),
          search ?? "",
          idCategory ?? "[]",
          descending ?? false,
          details ?? "",
          sortBy ?? "");

      print(res.data.data);

      return res.data.data;
    } catch (err) {
      handleError(err);
    }
  }
}
