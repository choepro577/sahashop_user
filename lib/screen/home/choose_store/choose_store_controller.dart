import 'package:get/get.dart';
import 'package:sahashop_user/data/remote/response/store/all_store_response.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';

class ChooseStoreController extends GetxController {
  var isLoading = false.obs;
  var errMsg = "".obs;
  RxList<Store> listStore = RxList<Store>();

  ChooseStoreController() {
    getListStore();
  }

  void getListStore() async {
    isLoading.value = true;
    errMsg.refresh();
    try {
      listStore(await RepositoryManager.storeRepository.getAll());
      isLoading.value = false;
    } catch (err) {
      errMsg.value = err;
      isLoading.value = false;
    }
  }
}
