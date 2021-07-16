import 'package:sahashop_user/app_customer/utils/store_info.dart';

import '../../remote/customer_service_manager.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/model/cart.dart';
import 'package:sahashop_user/app_user/model/order.dart';

class CartRepository {
  Future<Cart?> getItemCart() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getItemCart(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Cart?> addVoucherCart(String codeVoucher) async {
    try {
      var res = await CustomerServiceManager().service!.addVoucherCart(
          StoreInfo().getCustomerStoreCode(), {"code_voucher": codeVoucher});
      return res;
    } catch (err) {
      //SahaAlert.showError(message: err.toString());
    }
  }

  Future<Cart?> updateItemCart(int? idProduct, int quantity,
      List<DistributesSelected> listDistributes) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .updateItemCart(StoreInfo().getCustomerStoreCode(), {
        "product_id": idProduct,
        "quantity": quantity,
        "distributes":
            List<dynamic>.from(listDistributes.map((x) => x.toJson())),
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Cart?> addItemCart(
      int? idProduct, List<DistributesSelected> listDistributes) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .addItemCart(StoreInfo().getCustomerStoreCode(), {
        "product_id": idProduct,
        "distributes":
            List<dynamic>.from(listDistributes.map((x) => x.toJson())),
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
