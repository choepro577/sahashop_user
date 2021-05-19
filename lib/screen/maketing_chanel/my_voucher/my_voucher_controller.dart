import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';

import 'package:sahashop_user/model/voucher.dart';
import 'package:sahashop_user/model/voucher_request.dart';

class MyVoucherController extends GetxController {
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var isEndDiscount = false.obs;
  var listVoucherIsComing = RxList<Voucher>().obs;
  var listVoucherIsRunning = RxList<Voucher>().obs;
  var listVoucherIsEnd = RxList<Voucher>().obs;
  var listAll = RxList<List<Voucher>>([[], [], []]).obs;
  var listAllSaveStateBefore = RxList<List<Voucher>>([[], [], []]).obs;
  var listCheckHasDiscountState = RxList<bool>([false, false, false]).obs;
  var pageLoadMore = 1;
  var isEndPageVoucher = false;
  DateTime timeNow = DateTime.now();

  Future<void> getAllVoucher() async {
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllVoucher();

      res.data.forEach((element) {
        if (element.startTime.isAfter(timeNow)) {
          listVoucherIsComing.value.add(element);
        } else {
          if (element.endTime.isAfter(timeNow)) {
            listVoucherIsRunning.value.add(element);
          }
          // else {
          //   listVoucherIsEnd.value.add(element);
          // }
        }
      });

      listAll.value[0] = listVoucherIsComing.value;
      listAll.value[1] = listVoucherIsRunning.value;
      listAll.value[2] = listVoucherIsEnd.value;
      listAllSaveStateBefore.value = listAll.value;
    } catch (err) {
      handleError(err);
    }
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listVoucherIsComing = RxList<Voucher>().obs;
    listVoucherIsRunning = RxList<Voucher>().obs;
    listAll = RxList<List<Voucher>>([[], [], []]).obs;
    await getAllVoucher();
    isRefreshingData.value = false;
  }

  void loadInitEndVoucher() {
    pageLoadMore = 1;
    isEndPageVoucher = false;
    loadMoreEndVoucher();
  }

  Future<void> loadMoreEndVoucher() async {
    try {
      var res = await RepositoryManager.marketingChanel
          .getEndVoucherFromPage(pageLoadMore);

      if (!isEndPageVoucher) {
        res.data.data.forEach((element) {
          listVoucherIsEnd.value.add(element);
        });
      } else {
        return;
      }

      listAll.value[2] = listVoucherIsEnd.value;
      listAllSaveStateBefore = listAll;
      if (res.data.nextPageUrl != null) {
        pageLoadMore++;
        isEndPageVoucher = false;
      } else {
        isEndPageVoucher = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> endVoucher(int idVoucher) async {
    try {
      var data = await RepositoryManager.marketingChanel
          .updateVoucher(idVoucher, VoucherRequest(isEnd: true));
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    refreshData();
  }

  Future<void> deleteVoucher(
    int idVoucher,
  ) async {
    isDeletingDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.deleteVoucher(
        idVoucher,
      );
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingDiscount.value = false;
    refreshData();
  }
}
