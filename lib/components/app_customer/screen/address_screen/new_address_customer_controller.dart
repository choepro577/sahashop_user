import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/address_customer/address_customer_request.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/address/address_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/location_address.dart';

class NewAddressCustomerController extends GetxController {
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var isLoadingCreate = false.obs;
  var isDefault = false.obs;

  TextEditingController nameTextEditingController =
      TextEditingController(text: "");
  TextEditingController phoneTextEditingController =
      TextEditingController(text: "");
  TextEditingController addressDetailTextEditingController =
      TextEditingController(text: "");

  Future<void> createAddressCustomer() async {
    isLoadingCreate.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .createAddressCustomer(AddressCustomerRequest(
        name: nameTextEditingController.text,
        addressDetail: addressDetailTextEditingController.text,
        country: 1,
        province: locationProvince.value.id,
        district: locationDistrict.value.id,
        wards: locationWard.value.id,
        email: "hieudeptrai@gmail.com",
        phone: phoneTextEditingController.text,
        isDefault: isDefault.value,
      ));
      Get.back();
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }
}
