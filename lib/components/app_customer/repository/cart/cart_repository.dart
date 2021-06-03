import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/cart/cart_response.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/utils/user_info.dart';

class CartRepository {
  Future<CartCustomerResponse> getItemCart() async {
    try {
      var res = await CustomerServiceManager()
          .service
          .getItemCart(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<CartCustomerResponse> updateItemCart(
      int idProduct, int quantity) async {
    try {
      var res = await CustomerServiceManager()
          .service
          .updateItemCart(UserInfo().getCurrentStoreCode(), {
        "product_id": idProduct,
        "quantity": quantity,
      });
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<CartCustomerResponse> addItemCart(int idProduct) async {
    try {
      var res = await CustomerServiceManager()
          .service
          .addItemCart(UserInfo().getCurrentStoreCode(), {
        "product_id": idProduct,
      });
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
