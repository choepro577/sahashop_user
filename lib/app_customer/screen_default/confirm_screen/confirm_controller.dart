import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/cart_screen/cart_controller.dart';
import '../../remote/response-request/orders/order_request.dart';
import '../../repository/repository_customer.dart';
import '../../screen_default/order_completed_screen/order_completed_screen.dart';
import '../../screen_default/order_history/order_history_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/info_address_customer.dart';
import 'package:sahashop_user/app_user/model/shipment_method.dart';

class ConfirmController extends GetxController {
  var isLoadingOrder = false.obs;
  Rx<InfoAddressCustomer?> infoAddressCustomer = InfoAddressCustomer().obs;
  var isLoadingAddress = false.obs;
  var shipmentMethodCurrent = ShipmentMethod().obs;
  var listShipmentFast = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;
  var idPaymentCurrent = 0.obs;
  var paymentMethodName = "".obs;
  var opacityCurrent = 1.0.obs;
  var opacityPaymentCurrent = 1.0.obs;
  var colorAnimateAddress = Colors.transparent.obs;
  var colorAnimatePayment = Colors.transparent.obs;
  TextEditingController noteCustomerEditingController = TextEditingController();
  int partnerShipperId = 0;
  int shipperType = 0;
  int totalShippingFee = 0;

  CartController cartController = Get.find();

  ConfirmController() {
    shipmentMethodCurrent.value.fee = 0;
    infoAddressCustomer.value = InfoAddressCustomer(id: 0);
    getAllAddressCustomer();
  }

  Future<void> chargeShipmentFee(int? idAddressCustomer) async {
    isLoadingShipmentMethod.value = true;
    try {
      var res = await CustomerRepositoryManager.shipmentRepository
          .chargeShipmentFee(idAddressCustomer);
      shipmentMethodCurrent.value = res!.data!.data!.isEmpty
          ? ShipmentMethod(fee: 0)
          : res.data!.data![0];
    } catch (err) {
      infoAddressCustomer.value = InfoAddressCustomer(id: 0);
      SahaAlert.showError(message: "Chưa chọn địa chỉ");
    }
    isLoadingShipmentMethod.value = false;
  }

  Future<void> getAllAddressCustomer() async {
    isLoadingAddress.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .getAllAddressCustomer();
      infoAddressCustomer.value =
          res!.data!.isEmpty ? InfoAddressCustomer(id: 0) : res.data![0];
      res.data!.forEach((element) {
        if (element.isDefault!) {
          infoAddressCustomer.value = element;
        }
      });
      chargeShipmentFee(infoAddressCustomer.value!.id);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  Future<void> createOrders() async {
    if (infoAddressCustomer.value?.id == 0) {
      SahaAlert.showError(message: "Chưa chọn địa chỉ nhận ");
    } else {
      isLoadingOrder.value = true;
      var orderRequest = OrderRequest(
        paymentMethodId: idPaymentCurrent.value,
        partnerShipperId: shipmentMethodCurrent.value.partnerId,
        shipperType: shipmentMethodCurrent.value.shipType,
        totalShippingFee: shipmentMethodCurrent.value.fee,
        customerAddressId: infoAddressCustomer.value!.id,
        customerNote: noteCustomerEditingController.text,
      );
      try {
        var resultOrder = await CustomerRepositoryManager
            .orderCustomerRepository
            .createOrder(orderRequest);
        isLoadingOrder.value = false;
        Get.offNamedUntil(
            "customer_home", (route) => route.settings.name == "customer_home");
        Get.to(() => OrderHistoryScreen(
              initPage: 0,
            ));
        Get.to(() => OrderCompletedScreen(
              orderCode: resultOrder!.data!.orderCode!,
            ));
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isLoadingOrder.value = false;
    }
  }
}