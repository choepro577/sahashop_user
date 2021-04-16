import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

class ProductCustomerRepository {
  Future<List<Product>> getProductWithCategory(int idCategory) async {
    try {
      var res = await CustomerServiceManager()
          .service
          .getProductWithCategory(UserInfo().getCurrentstoreCode(), idCategory);
      return res.data.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
