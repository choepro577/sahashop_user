import 'package:get/get.dart';
import 'package:sahashop_user/data/remote/createShop/model/listTypeShop_respones.dart';
import 'package:sahashop_user/data/remote/remote_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';

class SetUpInfoShopController extends GetxController {
  var stateCreate = "".obs;
  var creating = false.obs;
 var listNameShop =RxList<String>();
  var mapTypeShop =  RxList<Map<String, String>>();

  Future<List<DataTypeShop>> getAllShopType () async {
      try {
        var listDataTypeShop = await RemoteManager.createShopService.getAllShopType();
        UserInfo().dataTypeShop = listDataTypeShop;
        for (var i in  listDataTypeShop) {
          listNameShop.add(i.name);
          mapTypeShop.add({i.id.toString() : i.name});
        }
        print(listNameShop);
        return listDataTypeShop;
      } catch (err) {
        return err;
      }
  }

  Future<bool> createShop(String nameShop, String address, String idType, String code) async {
    creating.value = true;
    try {
      var dataCreateShop = await RemoteManager.createShopService.createShop(nameShop: nameShop, address: address, idTypeShop: idType, code: code);
      UserInfo().dataCreateShop = dataCreateShop;
      creating.value = false;
      stateCreate.value = "success";
      return true;
    } catch (e) {
      creating.value = false;
      stateCreate.value = e.toString();
      stateCreate.refresh();
      return false;
    }
  }

}
