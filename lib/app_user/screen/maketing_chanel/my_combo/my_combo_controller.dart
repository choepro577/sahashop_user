import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/combo.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/marketing_chanel_response/combo/combo_request.dart';

class MyComboController extends GetxController {
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var listComboIsComing = RxList<Combo>().obs;
  var listComboIsRunning = RxList<Combo>().obs;
  var listComboIsEnd = RxList<Combo>().obs;
  var listAll = RxList<List<Combo>>([[], [], []]).obs;
  var listAllSaveStateBefore = RxList<List<Combo>>([[], [], []]).obs;
  var pageLoadMore = 1;
  var isEndPageCombo = false;
  DateTime timeNow = DateTime.now();

  Future<void> getAllCombo() async {
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllCombo();

      res!.data!.forEach((element) {
        if (element.startTime!.isAfter(timeNow)) {
          listComboIsComing.value.add(element);
        } else {
          if (element.endTime!.isAfter(timeNow)) {
            listComboIsRunning.value.add(element);
          }
          // else {
          //   listComboIsEnd.value.add(element);
          // }
        }
      });

      listAll.value[0] = listComboIsComing.value;
      listAll.value[1] = listComboIsRunning.value;
      listAll.value[2] = listComboIsEnd.value;
      listAllSaveStateBefore.value = listAll.value;
    } catch (err) {
      handleError(err);
    }
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listComboIsComing = RxList<Combo>().obs;
    listComboIsRunning = RxList<Combo>().obs;
    listAll = RxList<List<Combo>>([[], [], []]).obs;
    await getAllCombo();
    isRefreshingData.value = false;
  }

  void loadInitEndCombo() {
    pageLoadMore = 1;
    isEndPageCombo = false;
    loadMoreEndCombo();
  }

  Future<void> loadMoreEndCombo() async {
    try {
      var res = await RepositoryManager.marketingChanel
          .getEndComboFromPage(pageLoadMore);

      if (!isEndPageCombo) {
        res!.data!.data!.forEach((element) {
          listComboIsEnd.value.add(element);
        });
      } else {
        return;
      }

      listAll.value[2] = listComboIsEnd.value;
      listAllSaveStateBefore = listAll;
      if (res.data!.nextPageUrl != null) {
        pageLoadMore++;
        isEndPageCombo = false;
      } else {
        isEndPageCombo = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> endCombo(int? idCombo) async {
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
    int? idCombo,
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
