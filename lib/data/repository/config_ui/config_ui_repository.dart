import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/screen/config_app/model/config_app.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../handle_error.dart';

class ConfigUIRepository {
  Future<ConfigApp> createAppTheme(ConfigApp configApp) async {
    try {
      var res = await SahaServiceManager()
          .service
          .createAppTheme(UserInfo().getCurrentIdStore(), configApp.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ConfigApp> getAppTheme() async {
    try {
      var res = await SahaServiceManager()
          .service
          .getAppTheme(UserInfo().getCurrentIdStore());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
