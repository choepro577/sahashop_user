import 'package:get/get.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/discount_product_list.dart';

class MyProgramController extends GetxController {
  var isLoadingProgram = false.obs;
  var listProgramIsComing = RxList<DiscountProductsList>().obs;
  var hasDiscounted = false.obs;
  var listCheckHasDiscountState = RxList<bool>([false, false, false]).obs;

  Future<void> getAllDiscount() async {
    isLoadingProgram.value = true;
    try {
      var res = await RepositoryManager.marketingChanel.getAllDiscount();
      print(hasDiscounted.value);

      listProgramIsComing.value.addAll(res.data);
      if (res.data.isNotEmpty) {
        hasDiscounted.value = true;
        listCheckHasDiscountState.value[0] = true;
      }
    } catch (err) {
      handleError(err);
    }
    isLoadingProgram.value = false;
  }
}
