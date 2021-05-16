import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/my_program_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_controller.dart';

enum DiscountType { k0, k1 }

class CreateMyVoucherController extends GetxController {
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;

  AddProductToSaleController addProductToSaleController =
      Get.put(AddProductToSaleController());
  MyProgramController myProgramController = Get.find();

  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;

  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController discountEditingController = new TextEditingController();
  TextEditingController quantityEditingController = new TextEditingController();
  var hideShowVoucher = "Hiển thị".obs;

  var discountType = DiscountType.k1.obs;

  void onChangeDateStart(DateTime date) {
    if (date.isBefore(dateStart.value) == true) {
      checkDayStart.value = true;
      dateStart.value = date;
    } else {
      checkDayStart.value = false;
      dateStart.value = date;
    }
  }

  void onChangeDateEnd(DateTime date) {
    if (date.isBefore(dateStart.value) == true) {
      checkDayEnd.value = true;
      dateEnd.value = date;
    } else {
      checkDayEnd.value = false;
      dateEnd.value = date;
    }
  }

  void onChangeTimeEnd(DateTime date) {
    if (date.isBefore(timeStart.value) == true) {
      checkDayEnd.value = true;
      timeEnd.value = date;
    } else {
      checkDayEnd.value = false;
      timeEnd.value = date;
    }
  }
}
