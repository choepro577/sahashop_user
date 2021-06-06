import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/order_request.dart';
import 'package:sahashop_user/model/info_address_customer.dart';
import 'package:sahashop_user/model/shipment_method.dart';

class ConfirmController extends GetxController {
  var listItem = RxList<LineItem>();
  var isLoadingOrder = false.obs;
  var infoAddressCustomer = InfoAddressCustomer().obs;
  var isLoadingAddress = false.obs;
  var shipmentMethod = ShipmentMethod().obs;
  var listShipmentFast = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;

  DataAppCustomerController dataAppCustomerController = Get.find();

  ConfirmController() {
    shipmentMethod.value.fee = 0;
    infoAddressCustomer.value = null;
    getAllAddressCustomer();
  }

  Future<void> chargeShipmentFee(int idAddressCustomer) async {
    isLoadingShipmentMethod.value = true;
    try {
      var res = await CustomerRepositoryManager.shipmentRepository
          .chargeShipmentFee(idAddressCustomer);
      shipmentMethod.value = res.data.data[0];
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingShipmentMethod.value = false;
  }

  Future<void> getAllAddressCustomer() async {
    isLoadingAddress.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .getAllAddressCustomer();
      infoAddressCustomer.value = res.data[0];
      res.data.forEach((element) {
        if (element.isDefault) {
          infoAddressCustomer.value = element;
        }
      });
      chargeShipmentFee(infoAddressCustomer.value.id);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
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
