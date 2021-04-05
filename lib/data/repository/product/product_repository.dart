import 'package:sahashop_user/data/remote/response/product/product_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';


import '../handle_error.dart';
import 'product_request.dart';

class ProductRepository {
  Future<DataProductCreate> create(ProductRequest productRequest) async {
    try {
      var res = await SahaServiceManager()
          .service
          .createProduct(UserInfo().getCurrentIdStore(), productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Product>> getAllProduct() async {
    try {
      var res = await SahaServiceManager().service.getAllProduct(UserInfo().getCurrentIdStore());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
