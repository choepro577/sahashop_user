import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/order.dart';

class ProfileController extends GetxController {
  var loadMoreItemCount = 1;
  var processingAmount = 0.obs;
  var packingAmount = 0.obs;
  var shippingAmount = 0.obs;
  var evaluateAmount = 0.obs;

  ProfileController() {
    //
  }

  Future<void> countOrder() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getAllOrder(loadMoreItemCount, "", "", "", "", "", "", "");
      res!.data!.data!.forEach((element) {
        if (element.orderStatusCode == WAITING_FOR_PROGRESSING) {
          processingAmount.value++;
        }

        if (element.orderStatusCode == PACKING) {
          packingAmount.value++;
        }

        if (element.orderStatusCode == SHIPPING) {
          shippingAmount.value++;
        }

        if (element.orderStatusCode == COMPLETED) {
          evaluateAmount.value++;
        }
      });
      loadMoreItemCount++;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    if (loadMoreItemCount <= 2) {
      countOrder();
    }
  }
}