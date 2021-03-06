import 'package:sahashop_user/data/remote/response/store/type_store_respones.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';

import '../handle_error.dart';

class TypeOfShopRepository {
  Future<List<DataTypeShop>> getAll() async {
    try {
      var res = await SahaServiceManager().service.getAllTypeOfStore();
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
