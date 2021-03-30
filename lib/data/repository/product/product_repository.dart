import 'package:sahashop_user/data/remote/response/product/product_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';


import '../handle_error.dart';
import 'product_request.dart';

class ProductRepository {
  Future<DataProductCreate> create(ProductRequest productRequest) async {
    try {
      var res = await SahaServiceManager()
          .service
          .createProduct(UserInfo().currentIdStore, productRequest.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }

  }
}
