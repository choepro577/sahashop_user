import 'package:sahashop_user/app_user/data/remote/response-request/badge/badge_user_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class BadgeRepository {
  Future<BadgeUserResponse?> getBadgeUser() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getBadgeUser(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
