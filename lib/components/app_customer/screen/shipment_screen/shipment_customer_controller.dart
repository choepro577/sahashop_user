import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/info_address_customer.dart';
import 'package:sahashop_user/model/shipment_method.dart';

class ShipmentCustomerController extends GetxController {
  InfoAddressCustomer? infoAddressCustomer = InfoAddressCustomer();
  ShipmentMethod? shipmentCurrentInput;
  var listChooseShipmentMethod = RxList<bool>();
  late ShipmentMethod shipmentCurrentChoose;

  ShipmentCustomerController(
      {this.infoAddressCustomer, this.shipmentCurrentInput}) {
    chargeShipmentFee(infoAddressCustomer!.id);
  }

  var listShipment = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;
  var shipmentMethodChoose = ShipmentMethod().obs;

  Future<void> chargeShipmentFee(int? idAddressCustomer) async {
    isLoadingShipmentMethod.value = true;
    try {
      var res = await CustomerRepositoryManager.shipmentRepository
          .chargeShipmentFee(idAddressCustomer);
      listShipment(res!.data!.data!);

      listShipment.forEach((element) {
        listChooseShipmentMethod.add(false);
      });

      var index = listShipment.indexWhere(
          (element) => element.partnerId == shipmentCurrentInput!.partnerId);
      if (index != -1) {
        listChooseShipmentMethod[index] = true;
        shipmentCurrentChoose = listShipment[index];
        print(shipmentCurrentChoose.fee);
      }

      listChooseShipmentMethod[0] = true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingShipmentMethod.value = false;
  }

  void checkChooseShipment(bool value, int index) {
    listChooseShipmentMethod([]);
    listShipment.forEach((element) {
      listChooseShipmentMethod.add(false);
    });
    if (value == false) {
      listChooseShipmentMethod[index] = true;
      shipmentCurrentChoose = listShipment[index];
    }
  }
}
