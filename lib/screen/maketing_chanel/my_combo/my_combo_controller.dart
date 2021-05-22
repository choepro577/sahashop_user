import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/combo.dart';
import 'package:sahashop_user/data/remote/response-request/combo_request.dart';

import 'package:sahashop_user/model/voucher.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/voucher_request.dart';

class MyComboController extends GetxController {
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var isEndDiscount = false.obs;
  var listVoucherIsComing = RxList<Combo>().obs;
  var listVoucherIsRunning = RxList<Combo>().obs;
  var listVoucherIsEnd = RxList<Combo>().obs;
  var listAll = RxList<List<Combo>>([[], [], []]).obs;
  var listAllSaveStateBefore = RxList<List<Combo>>([[], [], []]).obs;
  var listCheckHasDiscountState = RxList<bool>([false, false, false]).obs;
  var pageLoadMore = 1;
  var isEndPageVoucher = false;
  DateTime timeNow = DateTime.now();

  Future<void> getAllCombo() async {
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllCombo();

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
    listVoucherIsComing = RxList<Combo>().obs;
    listVoucherIsRunning = RxList<Combo>().obs;
    listAll = RxList<List<Combo>>([[], [], []]).obs;
    await getAllCombo();
    isRefreshingData.value = false;
  }
  //
  // void loadInitEndVoucher() {
  //   pageLoadMore = 1;
  //   isEndPageVoucher = false;
  //   loadMoreEndVoucher();
  // }

  // Future<void> loadMoreEndVoucher() async {
  //   try {
  //     var res = await RepositoryManager.marketingChanel
  //         .getEndVoucherFromPage(pageLoadMore);
  //
  //     if (!isEndPageVoucher) {
  //       res.data.data.forEach((element) {
  //         listVoucherIsEnd.value.add(element);
  //       });
  //     } else {
  //       return;
  //     }
  //
  //     listAll.value[2] = listVoucherIsEnd.value;
  //     listAllSaveStateBefore = listAll;
  //     if (res.data.nextPageUrl != null) {
  //       pageLoadMore++;
  //       isEndPageVoucher = false;
  //     } else {
  //       isEndPageVoucher = true;
  //     }
  //   } catch (err) {
  //     SahaAlert.showError(message: err.toString());
  //   }
  // }

  Future<void> endCombo(int idCombo) async {
    try {
      var data = await RepositoryManager.marketingChanel
          .updateCombo(idCombo, ComboRequest(isEnd: true));
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    refreshData();
  }

  Future<void> deleteCombo(
    int idCombo,
  ) async {
    isDeletingDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.deleteCombo(
        idCombo,
      );
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingDiscount.value = false;
    refreshData();
  }
}
