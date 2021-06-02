import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/combo.dart';

class ComboDetailController extends GetxController {
  var listProductCombo = RxList<ProductsCombo>();

  ComboDetailController() {
    getComboCustomer();
  }

  Future<void> getComboCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      res.data.forEach((e) {
        listProductCombo(e.productsCombo);
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
