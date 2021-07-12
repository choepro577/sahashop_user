import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/app_user/model/button_home.dart';
import 'package:sahashop_user/app_user/model/config_app.dart';
import 'package:sahashop_user/app_user/model/home_data.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';
import '../handle_error.dart';

class ConfigUIRepository {
  Future<ConfigApp?> createAppTheme(ConfigApp configApp) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .createAppTheme(UserInfo().getCurrentStoreCode(), configApp.toJson());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ConfigApp?> getAppTheme() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAppTheme(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<HomeButton>?> updateAppButton(List<HomeButton> listButton) async {
    try {
      var res = await SahaServiceManager().service!.updateAppButton(
          UserInfo().getCurrentStoreCode(),
          {"home_buttons": listButton.map((e) => e.toJson()).toList()});
      return res.buttons;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<LayoutHome>?> updateLayoutSort(List<LayoutHome> listButton) async {
    try {
      var res = await SahaServiceManager().service!.updateLayoutSort(
          UserInfo().getCurrentStoreCode(),
          {"layouts": listButton.map((e) => e.toJson()).toList()});
      return res.buttons;
    } catch (err) {
      handleError(err);
    }
  }
}
