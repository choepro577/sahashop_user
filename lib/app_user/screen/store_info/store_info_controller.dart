import 'package:get/get.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/screen/home/home_controller.dart';

class StoreInfoController extends GetxController {

  StoreInfoController() {
    getInfoStore();
  }

  Future<void> getInfoStore() async {
    try {
      HomeController homeController = Get.find();
      var res = await RepositoryManager.storeRepository
          .getOne(homeController.storeCurrent!.value.storeCode);
      homeController.storeCurrent!(res);

    } catch (err) {}
  }
}
