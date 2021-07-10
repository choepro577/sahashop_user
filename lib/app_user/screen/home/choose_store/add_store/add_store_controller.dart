import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class AddStoreController extends GetxController {
  var creating = false.obs;
  var listNameShop = RxList<String?>();
  var mapTypeShop = RxList<Map<String, String>>();

  Future<List<DataTypeShop>?> getAllShopType() async {
    try {
      var listDataTypeShop =
          (await RepositoryManager.typeOfShopRepository.getAll())!;

      for (var i in listDataTypeShop) {
        listNameShop.add(i.name);
        mapTypeShop.add({i.id.toString(): i.name!});
      }
      print(listNameShop);
      mapTypeShop.refresh();
    } catch (err) {}
  }

  Future<void> createShop(
      String nameShop, String address, String? idType, String code) async {
    creating.value = true;
    try {
      var dataCreateShop = await RepositoryManager.storeRepository.create(
          UserInfo().getCurrentStoreCode(),
          nameShop: nameShop,
          address: address,
          idTypeShop: idType,
          code: code);

      creating.value = false;
      Get.back(result: "create_success");
      return;
    } catch (e) {
      creating.value = false;
      SahaAlert.showError(message: e.toString());
      return;
    }
  }
}
