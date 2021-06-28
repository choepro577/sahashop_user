import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/info_address.dart';
import 'package:sahashop_user/model/shipment.dart';

class ConfigStoreAddressController extends GetxController {
  var isLoadingAddress = false.obs;
  var listAddressStore = InfoAddress().obs;
  var listShipmentStore = RxList<Shipment>();

  ConfigStoreAddressController() {
    getAllAddressStore();
    getAllShipmentStore();
  }

  Future<void> addTokenShipment(
      int? shipmentId, ShipperConfig shipperConfig) async {
    try {
      var res = await RepositoryManager.addressRepository.addTokenShipment(
        shipmentId,
        shipperConfig,
      );
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllAddressStore() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getAllAddressStore();
      res!.data!.forEach((element) {
        if (element.isDefaultPickup == true) {
          listAddressStore.value = element;
        }
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  Future<void> getAllShipmentStore() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getAllShipmentStore();
      listShipmentStore(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  void refreshData() async {
    await getAllShipmentStore();
    await getAllAddressStore();
    listShipmentStore.refresh();
  }
}
