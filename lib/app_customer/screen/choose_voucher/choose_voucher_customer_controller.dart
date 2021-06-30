import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../repository/repository_customer.dart';
import '../../screen/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/voucher.dart';

class ChooseCustomerController extends GetxController {
  var listVoucher = RxList<Voucher>();
  var listChooseVoucher = RxList<bool>();
  var voucherCodeChoose = "".obs;
  var codeVoucherEditingController = TextEditingController().obs;

  DataAppCustomerController dataAppCustomerController = Get.find();

  ChooseCustomerController() {
    getVoucherCustomer();
  }

  Future<void> getVoucherCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getVoucherCustomer();
      listVoucher(res!.data!);
      listVoucher.forEach((element) {
        listChooseVoucher.add(false);
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void enterCodeVoucher(BuildContext context) async {
    await dataAppCustomerController
        .addVoucherCart(codeVoucherEditingController.value.text);
    if (dataAppCustomerController.voucherDiscountAmount.value == 0.0) {
      codeVoucherEditingController.value.text = "";
      codeVoucherEditingController.refresh();
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(
                  "Bạn chưa đủ điều kiện sử dụng Voucher này !",
                ),
                content: Text(
                    "Vui lòng xem điều kiện sử dụng Voucher, hoặc sử dụng Voucher khác !"),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Thoát",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ));
    }
  }

  void checkConditionVoucher(BuildContext context) async {
    await dataAppCustomerController.addVoucherCart(voucherCodeChoose.value);
    if (dataAppCustomerController.voucherDiscountAmount.value == 0.0) {
      listChooseVoucher([]);
      listVoucher.forEach((element) {
        listChooseVoucher.add(false);
      });
      voucherCodeChoose.value = "";
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(
                  "Bạn chưa đủ điều kiện sử dụng Voucher này !",
                  style: TextStyle(fontSize: 17),
                ),
                content: Text(
                  "Vui lòng xem điều kiện sử dụng Voucher, hoặc sử dụng Voucher khác !",
                  style: TextStyle(fontSize: 15),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Thoát",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ));
      dataAppCustomerController.voucherCodeChoose.value = "";
    } else {
      dataAppCustomerController.voucherCodeChoose.value =
          voucherCodeChoose.value;
      Get.back();
    }
  }

  void checkChooseVoucher(bool value, int index) {
    listChooseVoucher([]);
    listVoucher.forEach((element) {
      listChooseVoucher.add(false);
    });
    voucherCodeChoose.value = "";
    if (value == false) {
      listChooseVoucher[index] = true;
      voucherCodeChoose.value = listVoucher[index].code!;
    }
  }
}
