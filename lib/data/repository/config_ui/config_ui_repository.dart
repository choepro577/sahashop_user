import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/screen/config_app/model/config_app.dart';
import '../handle_error.dart';

class ConfigUIRepository {
  Future<ConfigApp> createAppTheme(ConfigApp configApp) async {
    try {
      var res =
          await SahaServiceManager().service.createAppTheme(configApp.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
