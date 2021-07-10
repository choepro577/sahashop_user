import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/utils/showcase.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class HomeController extends GetxController {
  HomeController() {
    loadStoreCurrent();
    checkIsFirstTimeLogin();
  }

  var preIsPortrait = false;
  var isExpansion = false.obs;
  var opacity = 1.0.obs;
  Rx<Store>? storeCurrent = Store().obs;
  var isLoadingStore = false.obs;
  var errMsg = "".obs;
  var checkNoStore = false.obs;
  var isFirstTimeLogin = false.obs;
  var requiredProduct = false.obs;

  Future<void> checkIsFirstTimeLogin() async {
    bool? check = ShowCase().getState();
    if (check == null || check == true) {
      isFirstTimeLogin.value = true;
      print("--------$isFirstTimeLogin");
    }
  }

  void onChangeExpansion(bool value) {
    isExpansion.value = value;
  }

  void changeOpacityText(double va) {
    opacity.value = va;
  }

  void loadStoreCurrent() async {
    isLoadingStore.value = true;
    errMsg.refresh();
    try {
      var list = (await RepositoryManager.storeRepository.getAll())!;

      if (list.length > 0) {
        var indexStoreSelected;
        if (UserInfo().getCurrentStoreCode() != null) {
          indexStoreSelected = list.indexWhere(
              (storeE) => storeE.storeCode == UserInfo().getCurrentStoreCode());
        }

        if (indexStoreSelected != null && indexStoreSelected >= 0) {
        } else {
          indexStoreSelected = 0;
        }

        Store store;
        store = list[indexStoreSelected];

        setNewStoreCurrent(store);
        setUserIdCurrent(store);
      } else {
        checkNoStore.value = true;
        // storeCurrent = null;
        UserInfo().setCurrentStoreCode(null);
      }

      isLoadingStore.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      errMsg.value = err.toString();
      isLoadingStore.value = false;
    }
  }

  void setNewStoreCurrent(Store store) {
    checkNoStore.value = false;
    UserInfo().setCurrentStoreCode(store.storeCode);
    storeCurrent!.value = store;
  }

  void setUserIdCurrent(Store store) {
    UserInfo().setCurrentIdUser(store.userId);
  }
}
