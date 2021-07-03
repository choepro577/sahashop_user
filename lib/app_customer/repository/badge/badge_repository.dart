import 'package:sahashop_user/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/app_customer/remote/response-request/badge/badge_response.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class BadgeRepository {
  Future<BadgeResponse?> getBadge() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getBadge(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
