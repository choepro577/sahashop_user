import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/attributes.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../handle_error.dart';

class AttributesRepository {

  Future<List<Attribute>> getAllAttributes() async {
    try {
      var res = await SahaServiceManager()
          .service
         .getAllAttributeFields(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Attribute>> addAllAttributes() async {
    try {
      var res = await SahaServiceManager()
          .service
          .getAllAttributeFields(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
