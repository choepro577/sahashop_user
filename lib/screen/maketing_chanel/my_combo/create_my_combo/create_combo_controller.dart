import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/combo_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_combo/create_my_combo/add_product/add_product_combo_controller.dart';

enum DiscountType { k0, k1 }

class CreateMyComboController extends GetxController {
  var isLoadingCreate = false.obs;
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;

  AddProductComboController addProductComboController =
      Get.put(AddProductComboController());

  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;

  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController valueEditingController = new TextEditingController();
  TextEditingController amountEditingController = new TextEditingController();
  TextEditingController amountCodeAvailableEditingController =
      new TextEditingController();

  var textHideShowVoucher = "Hiển thị".obs;
  var isShowVoucher = true.obs;
  var isLimitedPrice = true.obs;
  var typeVoucherDiscount = "Chọn".obs;
  var isChoosedTypeVoucherDiscount = true.obs;
  var isCheckMinimumOrderDiscount = true.obs;

  var discountType = DiscountType.k1.obs;
  var discountTypeRequest = 0.obs;

  var validateComboPercent = false.obs;

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

  void checkTypeDiscount() {
    if (discountType.value == DiscountType.k1) {
      typeVoucherDiscount.value = "Giảm ${valueEditingController.text} %";
    } else {
      typeVoucherDiscount.value = "Giảm đ${valueEditingController.text}";
    }
  }

  void onChangeRatio(DiscountType v) {
    if (discountType.value == DiscountType.k1) {
      valueEditingController.text = "";
      amountEditingController.text = "";
    } else {
      valueEditingController.text = "";
      amountEditingController.text = "";
    }
    discountType.value = v;
    if (discountType.value == DiscountType.k1) {
      discountTypeRequest.value = 1;
    } else {
      discountTypeRequest.value = 0;
    }
    print(discountTypeRequest.value);
  }

  Future<void> createCombo() async {
    isLoadingCreate.value = true;
    try {
      var res = await RepositoryManager.marketingChanel.createCombo(
        ComboRequest(
          name: nameProgramEditingController.text,
          description: "",
          imageUrl: "",
          startTime: DateTime(
                  dateStart.value.year,
                  dateStart.value.month,
                  dateStart.value.day,
                  timeStart.value.hour,
                  timeStart.value.minute,
                  timeStart.value.second,
                  timeStart.value.millisecond,
                  timeStart.value.microsecond)
              .toIso8601String(),
          endTime: DateTime(
                  dateEnd.value.year,
                  dateEnd.value.month,
                  dateEnd.value.day,
                  timeEnd.value.hour,
                  timeEnd.value.minute,
                  timeEnd.value.second,
                  timeEnd.value.millisecond,
                  timeEnd.value.microsecond)
              .toIso8601String(),
          discountType: discountTypeRequest.value,
          valueDiscount: valueEditingController.text.isEmpty
              ? int.parse(amountEditingController.text)
              : int.parse(valueEditingController.text),
          setLimitAmount: true,
          amount: amountCodeAvailableEditingController.text.isEmpty
              ? 0
              : int.parse(amountCodeAvailableEditingController.text),
          comboProducts:
              addProductComboController.listSelectedProductParam.value.toJson(),
        ),
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
    Get.back();
  }
}
