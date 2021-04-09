import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
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

      if (UserInfo().getCurrentIdStore() != null && list.length > 0) {
        var stores = list
            .where((storeE) => storeE?.id == UserInfo().getCurrentIdStore()).toList();
         Store store;
        if(stores.length>0){
          store= stores[0];
        }

        if (store != null) {
          setNewStoreCurrent(store);
          setUserIdCurrent(store);
        } else {
          setNewStoreCurrent(list[0]);
          setUserIdCurrent(list[0]);
        }
      } else if (UserInfo().getCurrentIdStore() == null && list.length > 0) {
        setNewStoreCurrent(list[0]);
        setUserIdCurrent(list[0]);
      } else {
        storeCurrent = null;
        UserInfo().setCurrentIdStore(null);
      }

      isLoadingStore.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      errMsg.value = err.toString();
      isLoadingStore.value = false;
    }
  }

  void setNewStoreCurrent(Store store) {
    UserInfo().setCurrentIdStore(store.id);
    storeCurrent.value = store;
  }

  void setUserIdCurrent(Store store) {
    UserInfo().setCurrentIdUser(store.userId);
  }
}
