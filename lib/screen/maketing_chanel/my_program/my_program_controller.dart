import 'package:get/get.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/discount_product_list.dart';

class MyProgramController extends GetxController {
  var isLoadingProgram = false.obs;
  var isRefreshingData = false.obs;
  var listProgramIsComing = RxList<DiscountProductsList>().obs;
  var listProgramIsRunning = RxList<DiscountProductsList>().obs;
  var listProgramIsEnd = RxList<DiscountProductsList>().obs;
  var listAll = RxList<RxList<DiscountProductsList>>().obs;
  var hasDiscounted = false.obs;
  var listCheckHasDiscountState = RxList<bool>([false, false, false]).obs;
  DateTime timeNow = DateTime.now();

  Future<void> getAllDiscount() async {
    isLoadingProgram.value = true;
    try {
      var res = await RepositoryManager.marketingChanel.getAllDiscount();

      if (res.data.isNotEmpty) {
        hasDiscounted.value = true;
      }

      res.data.forEach((element) {
        if (element.startTime.isAfter(timeNow)) {
          listProgramIsComing.value.add(element);
        } else {
          if (element.endTime.isAfter(timeNow)) {
            listProgramIsRunning.value.add(element);
          } else {
            listProgramIsEnd.value.add(element);
          }
        }
      });

      listAll.value.add(listProgramIsComing.value);
      listAll.value.add(listProgramIsRunning.value);
      listAll.value.add(listProgramIsEnd.value);
    } catch (err) {
      handleError(err);
    }
    isLoadingProgram.value = false;
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listProgramIsComing = RxList<DiscountProductsList>().obs;
    listProgramIsRunning = RxList<DiscountProductsList>().obs;
    listProgramIsEnd = RxList<DiscountProductsList>().obs;
    listAll = RxList<RxList<DiscountProductsList>>().obs;
    await getAllDiscount();
    isRefreshingData.value = false;
  }
}
