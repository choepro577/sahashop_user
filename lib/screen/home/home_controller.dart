import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/const/const_database_hive.dart';
import 'package:sahashop_user/data/remote/response/store/all_store_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

class HomeController extends GetxController {
  HomeController() {
    loadStoreCurrent();
  }

  var isExpansion = false.obs;
  var storeCurrent = Store().obs;
  var isLoadingStore = false.obs;
  var errMsg = "".obs;
  void onChangeExpansion(bool value) {
    isExpansion.value = value;
  }

  void loadStoreCurrent() async {
    isLoadingStore.value = true;
    errMsg.refresh();
    try {
      var list = await RepositoryManager.storeRepository.getAll();

      if (list.length > 0) {
        var indexStoreSelected;
        if (UserInfo().getCurrentStoreCode() != null) {
          indexStoreSelected = list.indexWhere((storeE) =>
              storeE?.storeCode == UserInfo().getCurrentStoreCode());
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
        storeCurrent = null;
        UserInfo().setCurrentStoreCode(null);
      }

      isLoadingStore.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      errMsg.value = err.toString();
      isLoadingStore.value = false;
    }
    Hive.openBox(CART + '${UserInfo().getCurrentStoreCode()}');
  }

  void setNewStoreCurrent(Store store) {
    UserInfo().setCurrentStoreCode(store.storeCode);
    storeCurrent.value = store;
  }

  void removeAndCloseHiveBox(Store store) {
    final box = Hive.box(CART + '${store.storeCode}');
    box.deleteFromDisk();
  }

  void setUserIdCurrent(Store store) {
    UserInfo().setCurrentIdUser(store.userId);
  }
}
