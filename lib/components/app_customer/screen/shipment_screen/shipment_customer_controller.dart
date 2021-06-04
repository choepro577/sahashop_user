import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/info_address_customer.dart';
import 'package:sahashop_user/model/shipment_method.dart';

class ShipmentCustomerController extends GetxController {
  var infoAddressCustomer = InfoAddressCustomer();
  var isShipmentInput = true;

  ShipmentCustomerController({this.infoAddressCustomer, this.isShipmentInput}) {
    chargeShipmentFee(infoAddressCustomer.id);
    isShipmentFast.value = isShipmentInput;
  }

  var isShipmentFast = true.obs;
  var listShipmentFast = RxList<ShipmentMethod>();
  var listShipmentSupperSpeed = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;
  var shipmentMethodChoose = ShipmentMethod().obs;

  Future<void> chargeShipmentFee(int idAddressCustomer) async {
    isLoadingShipmentMethod.value = true;
    try {
      var res = await CustomerRepositoryManager.shipmentRepository
          .chargeShipmentFee(idAddressCustomer);
      res.data.data.forEach((element) {
        if (element.shipType == 0) {
          listShipmentFast.add(element);
        } else {
          listShipmentSupperSpeed.add(element);
        }
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingShipmentMethod.value = false;
  }

  void changeShipmentMethod(bool value) {
    if (value == true) {
      isShipmentFast.value = true;
      shipmentMethodChoose.value = listShipmentFast[0];
    } else {
      isShipmentFast.value = false;
      shipmentMethodChoose.value = listShipmentSupperSpeed[0];
    }
  }
}
