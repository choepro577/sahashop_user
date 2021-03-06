import 'package:sahashop_user/data/remote/response/store/all_store_response.dart';
import 'package:sahashop_user/data/remote/response/store/create_store_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';

import '../handle_error.dart';

class StoreRepository {
  Future<DataCreateShop> create(String storeCode,
      {String nameShop, String address, String idTypeShop, String code}) async {
    try {
      var res = await SahaServiceManager().service.createStore({
        "name": nameShop,
        "store_code": code,
        "address": address,
        "id_type_of_store": idTypeShop
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Store>> getAll() async {
    try {
      var res = await SahaServiceManager().service.getAllStore();
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
