import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/home_data.dart';


class LayoutSortChangeController extends GetxController {
  var loading = false.obs;
  var listLayout = RxList<LayoutHome>();
  DataAppCustomerController dataAppCustomerController = Get.find();

  LayoutSortChangeController() {
    getAllLayout();
  }

  Future<bool?> getAllLayout() async {
    loading.value = true;
    try {
      await dataAppCustomerController.getHomeData();
      listLayout(dataAppCustomerController.homeData!.listLayout!);
      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> updateLayout() async {

    try {
      var list = await RepositoryManager.configUiRepository
          .updateLayoutSort(listLayout.toList());
      await dataAppCustomerController.getHomeData();
      listLayout(list!);

      SahaAlert.showError(message: "Đã cập nhật");
      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  void changeIndex(int oldIndex, int newIndex) {
    var pre = listLayout[oldIndex];
    listLayout.removeAt(oldIndex);
    listLayout.insert(newIndex, pre);
    updateLayout();
  }

  Future<void> changeHide(LayoutHome va) async {
    var index = listLayout.indexOf(va);
    listLayout[index].hide = !(listLayout[index].hide ?? false);
    updateLayout();
  }
}
