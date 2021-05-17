import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';

import 'package:sahashop_user/model/voucher.dart';

class MyVoucherController extends GetxController {
  var isLoadingVoucher = false.obs;
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var isEndDiscount = false.obs;
  var listVoucherIsComing = RxList<Voucher>().obs;
  var listVoucherIsRunning = RxList<Voucher>().obs;
  var listVoucherIsEnd = RxList<Voucher>().obs;
  var listAll = RxList<List<Voucher>>([[], [], []]).obs;
  var listAllSaveStateBefore = RxList<List<Voucher>>([[], [], []]).obs;
  var hasDiscounted = false.obs;
  var listCheckHasDiscountState = RxList<bool>([false, false, false]).obs;
  DateTime timeNow = DateTime.now();

  Future<void> getAllVoucher() async {
    isLoadingVoucher.value = true;
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllVoucher();

      if (res.data.isNotEmpty) {
        hasDiscounted.value = true;
      }

      res.data.forEach((element) {
        if (element.startTime.isAfter(timeNow)) {
          listVoucherIsComing.value.add(element);
        } else {
          if (element.endTime.isAfter(timeNow)) {
            listVoucherIsRunning.value.add(element);
          } else {
            listVoucherIsEnd.value.add(element);
          }
        }
      });

      listAll.value[0] = listVoucherIsComing.value;
      listAll.value[1] = listVoucherIsRunning.value;
      listAll.value[2] = listVoucherIsEnd.value;
      listAllSaveStateBefore = listAll;
    } catch (err) {
      handleError(err);
    }
    isLoadingVoucher.value = false;
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listVoucherIsComing = RxList<Voucher>().obs;
    listVoucherIsRunning = RxList<Voucher>().obs;
    listVoucherIsEnd = RxList<Voucher>().obs;
    listAll = RxList<List<Voucher>>([[], [], []]).obs;
    await getAllVoucher();
    isRefreshingData.value = false;
  }

  Future<void> endDiscount(
    int idDiscount,
    bool isEnd,
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    int value,
    bool setLimitedAmount,
    int amount,
    String listIdProduct,
  ) async {
    isEndDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.updateDiscount(
          idDiscount,
          isEnd,
          name,
          description,
          imageUrl,
          startTime,
          endTime,
          value,
          setLimitedAmount,
          amount,
          listIdProduct);
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isEndDiscount.value = false;
  }

  Future<void> deleteDiscount(
    int idDiscount,
  ) async {
    isDeletingDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.deleteDiscount(
        idDiscount,
      );
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingDiscount.value = false;
  }
}
