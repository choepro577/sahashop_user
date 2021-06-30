import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/remote/response-request/address_customer/address_customer_request.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/info_address_customer.dart';
import 'package:sahashop_user/app_user/model/location_address.dart';

class ConfigAddressCustomerController extends GetxController {
  InfoAddressCustomer? infoAddressCustomer;

  var isDefault = false.obs;
  var nameTextEditingController = TextEditingController(text: "").obs;
  var phoneTextEditingController = TextEditingController(text: "").obs;
  var addressDetailTextEditingController = TextEditingController(text: "").obs;
  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;
  var isLoadingUpdate = false.obs;
  var isDeletingAddressStore = false.obs;

  ConfigAddressCustomerController({this.infoAddressCustomer}) {
    nameTextEditingController.value.text = infoAddressCustomer!.name ?? " ";
    phoneTextEditingController.value.text = infoAddressCustomer!.phone ?? " ";
    addressDetailTextEditingController.value.text =
        infoAddressCustomer!.addressDetail ?? " ";
    isDefault.value = infoAddressCustomer!.isDefault!;
    locationProvince.value.name = infoAddressCustomer!.provinceName;
    locationDistrict.value.name = infoAddressCustomer!.districtName;
    locationWard.value.name = infoAddressCustomer!.wardsName;
    locationProvince.value.id = infoAddressCustomer!.province;
    locationDistrict.value.id = infoAddressCustomer!.district;
    locationWard.value.id = infoAddressCustomer!.wards;
  }

  Future<void> updateAddressCustomer() async {
    isLoadingUpdate.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .updateAddressCustomer(
              infoAddressCustomer!.id,
              AddressCustomerRequest(
                name: nameTextEditingController.value.text,
                addressDetail: addressDetailTextEditingController.value.text,
                country: 1,
                province: locationProvince.value.id,
                district: locationDistrict.value.id,
                wards: locationWard.value.id,
                email: "hieudeptrai@gmail.com",
                phone: phoneTextEditingController.value.text,
                isDefault: isDefault.value,
              ));
      Get.back();
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingUpdate.value = false;
  }

  Future<void> deleteAddressCustomer() async {
    isDeletingAddressStore.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .deleteAddressCustomer(infoAddressCustomer!.id);
      Get.back();
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingAddressStore.value = false;
  }
}
