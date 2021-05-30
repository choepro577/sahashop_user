import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/address/address_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/location_address.dart';

class NewAddressController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var isLoadingCreate = false.obs;
  var isDefaultPickup = true.obs;
  var isDefaultReturn = true.obs;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController addressDetailTextEditingController =
      TextEditingController();

  Future<void> createAddressStore() async {
    isLoadingCreate.value = true;
    try {
      var res = await RepositoryManager.addressRepository
          .createAddressStore(AddressRequest(
        name: nameTextEditingController.text,
        addressDetail: addressDetailTextEditingController.text,
        country: 1,
        province: locationProvince.value.id,
        district: locationDistrict.value.id,
        wards: locationWard.value.id,
        email: "hieudeptrai@gmail.com",
        phone: phoneTextEditingController.text,
        isDefaultPickup: isDefaultPickup.value,
        isDefaultReturn: isDefaultReturn.value,
      ));
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }
}