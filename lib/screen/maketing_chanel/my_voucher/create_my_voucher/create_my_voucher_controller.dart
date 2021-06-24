import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/voucher_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/product.dart';

enum DiscountType { k0, k1 }

class CreateMyVoucherController extends GetxController {
  var isLoadingCreate = false.obs;
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;
  var listSelectedProduct = RxList<Product>();
  var listProductParam = "";

  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;

  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController codeVoucherEditingController =
      new TextEditingController();
  TextEditingController pricePermanentEditingController =
      new TextEditingController();
  TextEditingController pricePercentEditingController =
      new TextEditingController();
  TextEditingController priceDiscountLimitedEditingController =
      new TextEditingController();
  TextEditingController minimumOrderEditingController =
      new TextEditingController();
  TextEditingController amountCodeAvailableEditingController =
      new TextEditingController();

  var textHideShowVoucher = "Hiển thị".obs;
  var isShowVoucher = true.obs;
  var isLimitedPrice = true.obs;
  var typeVoucherDiscount = "Chọn loại giảm giá".obs;
  var isChoosedTypeVoucherDiscount = true.obs;
  var isCheckMinimumOrderDiscount = true.obs;

  Rx<DiscountType?> discountType = DiscountType.k1.obs;
  var discountTypeRequest = 0.obs;

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
    if (pricePermanentEditingController.text.isEmpty) {
      if (priceDiscountLimitedEditingController.text.isEmpty) {
        typeVoucherDiscount.value =
            "Không giới hạn - " + pricePercentEditingController.text + "%";
      } else {
        typeVoucherDiscount.value = "Giới hạn - " +
            priceDiscountLimitedEditingController.text +
            "đ -" +
            pricePercentEditingController.text +
            "%";
      }
    } else {
      typeVoucherDiscount.value =
          "Cố định - " + pricePermanentEditingController.text + "đ";
    }
  }

  void onChangeRatio(DiscountType? v) {
    if (discountType.value == DiscountType.k1) {
      pricePermanentEditingController.text = "";
    } else {
      pricePercentEditingController.text = "";
      priceDiscountLimitedEditingController.text = "";
    }
    discountType.value = v;
    if (discountType.value == DiscountType.k1) {
      discountTypeRequest.value = 0;
    } else {
      discountTypeRequest.value = 1;
    }
  }

  void deleteProduct(int idProduct) {
    listSelectedProduct.removeWhere((product) => product.id == idProduct);
    listSelectedProduct.refresh();
  }

  void listSelectedProductToString() {
    listSelectedProduct.forEach((element) {
      if (element != listSelectedProduct.last) {
        listProductParam = listProductParam + "${element.id.toString()},";
      } else {
        listProductParam = listProductParam + "${element.id.toString()}";
      }
    });
    print(listProductParam);
  }

  Future<void> createVoucher(int? voucherType) async {
    isLoadingCreate.value = true;
    try {
      var res = await RepositoryManager.marketingChanel.createVoucher(
        VoucherRequest(
            isShowVoucher: isShowVoucher.value,
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
            voucherType: voucherType,
            discountType: discountTypeRequest.value,
            valueDiscount: pricePermanentEditingController.text.isEmpty
                ? int.parse(pricePercentEditingController.text)
                : int.parse(pricePermanentEditingController.text),
            setLimitValueDiscount: isLimitedPrice.value,
            maxValueDiscount: priceDiscountLimitedEditingController.text.isEmpty
                ? 0
                : int.parse(priceDiscountLimitedEditingController.text),
            setLimitTotal: true,
            valueLimitTotal: minimumOrderEditingController.text.isEmpty
                ? 0
                : int.parse(minimumOrderEditingController.text),
            setLimitAmount: true,
            amount: amountCodeAvailableEditingController.text.isEmpty
                ? 0
                : int.parse(amountCodeAvailableEditingController.text),
            code: codeVoucherEditingController.text,
            products: listProductParam),
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }
}
