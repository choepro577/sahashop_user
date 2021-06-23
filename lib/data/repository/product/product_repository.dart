import 'package:sahashop_user/data/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

import '../handle_error.dart';

class ProductRepository {
  Future<bool?> delete(int idProduct) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteProduct(UserInfo().getCurrentStoreCode(), idProduct);
      return res.data!.idDeleted == idProduct;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Product?> create(ProductRequest productRequest) async {
    try {
      var res = await SahaServiceManager().service!.createProduct(
          UserInfo().getCurrentStoreCode(), productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Product?> update(int idProduct, ProductRequest productRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateProduct(
          UserInfo().getCurrentStoreCode(), idProduct, productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DataPageProduct?> getAllProduct(
      {String? search,
      String? idCategory,
      bool? descending,
      String? status,
      String? filterBy,
      String? filterOption,
      String? filterByValue,
      String? details,
      String? sortBy,
      int? page}) async {
    try {
      var res = await SahaServiceManager().service!.getAllProduct(
          UserInfo().getCurrentStoreCode(),
          search ?? "",
          idCategory ?? "",
          descending ?? false,
          status?? "",
          filterBy?? "",
          filterOption?? "",
          filterByValue?? "",
          details ?? "",
          sortBy ?? "",
          page ?? 1);

      print(res.data!.data);

      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
