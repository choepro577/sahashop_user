import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/discount_product_list.dart';

class MyProgramController extends GetxController {
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var isEndDiscount = false.obs;
  var listProgramIsComing = RxList<DiscountProductsList>().obs;
  var listProgramIsRunning = RxList<DiscountProductsList>().obs;
  var listProgramIsEnd = RxList<DiscountProductsList>().obs;
  var listAll = RxList<List<DiscountProductsList>>([[], [], []]).obs;
  var listAllSaveStateBefore =
      RxList<List<DiscountProductsList>>([[], [], []]).obs;
  var hasDiscounted = false.obs;
  var listCheckHasDiscountState = RxList<bool>([false, false, false]).obs;
  DateTime timeNow = DateTime.now();

  var pageLoadMore = 1;
  var isEndPageDiscount = false;

  Future<void> getAllDiscount() async {
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllDiscount();

      if (res!.data!.isNotEmpty) {
        hasDiscounted.value = true;
      }

      res.data!.forEach((element) {
        if (element.startTime!.isAfter(timeNow)) {
          listProgramIsComing.value.add(element);
        } else {
          if (element.endTime!.isAfter(timeNow)) {
            listProgramIsRunning.value.add(element);
          }
          // else {
          //   listProgramIsEnd.value.add(element);
          // }
        }
      });

      listAll.value[0] = listProgramIsComing.value;
      listAll.value[1] = listProgramIsRunning.value;
      listAll.value[2] = listProgramIsEnd.value;
      listAllSaveStateBefore.value = listAll.value;
    } catch (err) {
      handleError(err);
    }
  }

  void loadInitEndDiscount() {
    pageLoadMore = 1;
    isEndPageDiscount = false;
    loadMoreEndDiscount();
  }

  Future<void> loadMoreEndDiscount() async {
    try {
      var res = await RepositoryManager.marketingChanel
          .getEndDiscountFromPage(pageLoadMore);

      if (!isEndPageDiscount) {
        res!.data!.data!.forEach((element) {
          listProgramIsEnd.value.add(element);
        });
      } else {
        return;
      }

      listAll.value[2] = listProgramIsEnd.value;
      listAllSaveStateBefore = listAll;
      if (res.data!.nextPageUrl != null) {
        pageLoadMore++;
        isEndPageDiscount = false;
      } else {
        isEndPageDiscount = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listProgramIsComing = RxList<DiscountProductsList>().obs;
    listProgramIsRunning = RxList<DiscountProductsList>().obs;
    listProgramIsEnd = RxList<DiscountProductsList>().obs;
    listAll = RxList<List<DiscountProductsList>>([[], [], []]).obs;
    await getAllDiscount();
    isRefreshingData.value = false;
  }

  Future<void> endDiscount(
    int? idDiscount,
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
    refreshData();
  }

  Future<void> deleteDiscount(
    int? idDiscount,
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
    refreshData();
  }
}
