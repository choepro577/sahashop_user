import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/model/info_address_customer.dart';

class ConfigAddressCustomerController extends GetxController {
  InfoAddressCustomer infoAddressCustomer;

  var isDefault = false.obs;
  var nameTextEditingController = TextEditingController().obs;
  var phoneTextEditingController = TextEditingController().obs;
  var addressDetailTextEditingController = TextEditingController().obs;

  ConfigAddressCustomerController({this.infoAddressCustomer}) {
    nameTextEditingController.value.text = infoAddressCustomer.name;
    phoneTextEditingController.value.text = infoAddressCustomer.phone;
    addressDetailTextEditingController.value.text =
        infoAddressCustomer.addressDetail;
    isDefault.value = infoAddressCustomer.isDefault;
  }
}
