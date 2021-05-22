import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/model/info_address.dart';
import 'package:sahashop_user/model/location_address.dart';

class ConfigAddressController extends GetxController {
  final InfoAddress infoAddress;

  ConfigAddressController(this.infoAddress) {
    nameTextEditingController.text = infoAddress.name;
    phoneTextEditingController.text = infoAddress.phone;
    addressDetailTextEditingController.text = infoAddress.addressDetail;
    locationProvince.value.name = infoAddress.provinceName;
    locationDistrict.value.name = infoAddress.districtName;
    locationWard.value.name = infoAddress.wardsName;
    isDefaultPickup.value = infoAddress.isDefaultPickup;
    isDefaultReturn.value = infoAddress.isDefaultReturn;
  }

  var locationProvince = LocationAddress().obs;
  var locationDistrict = LocationAddress().obs;
  var locationWard = LocationAddress().obs;

  var isDefaultPickup = true.obs;
  var isDefaultReturn = true.obs;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController addressDetailTextEditingController =
      TextEditingController();
}
