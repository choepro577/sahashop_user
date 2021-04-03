import 'package:get/get.dart';
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
        var store = list
            .where((store) => store.id == UserInfo().getCurrentIdStore())
            .first;

        if (store != null) {
          setNewStoreCurrent(store);
        } else {
          setNewStoreCurrent(list[0]);
        }
      }
     else if (UserInfo().getCurrentIdStore() == null && list.length > 0) {
        setNewStoreCurrent(list[0]);
      } else {
        storeCurrent = null;
        UserInfo().setCurrentIdStore(null);
      }

      isLoadingStore.value = false;
    } catch (err) {
      errMsg.value = err;
      isLoadingStore.value = false;
    }
  }

  void setNewStoreCurrent(Store store) {
    UserInfo().setCurrentIdStore(store.id);
    storeCurrent.value = store;
  }
}
