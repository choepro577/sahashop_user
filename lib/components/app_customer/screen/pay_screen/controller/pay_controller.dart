import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/order_request.dart';
import 'package:sahashop_user/model/info_address_customer.dart';

class PayController extends GetxController {
  var listItem = RxList<LineItem>();
  var totalMoney = 0.0.obs;
  var infoAddressCustomer = InfoAddressCustomer().obs;
  var isLoadingOrder = false.obs;

  DataAppCustomerController dataAppCustomerController = Get.find();

  PayController() {
    infoAddressCustomer.value = null;
  }

  Future<void> createOrders() async {
    if (infoAddressCustomer.value == null) {
      SahaAlert.showError(message: "Chưa chọn địa chỉ nhận ");
    } else {
      isLoadingOrder.value = true;
      var orderRequest = OrderRequest(
          infoContact: infoAddressCustomer.value,
          infoReceiver: infoAddressCustomer.value,
          lineItems: listItem);
      try {
        var resultOrder = await CustomerRepositoryManager
            .createOrderCustomerRepository
            .createOrder(orderRequest);
        isLoadingOrder.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isLoadingOrder.value = false;
    }
  }
}
