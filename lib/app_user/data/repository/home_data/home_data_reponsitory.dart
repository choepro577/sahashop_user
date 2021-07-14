import 'package:sahashop_user/app_user/data/remote/response-request/home_data/home_data_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';


class HomeDataRepository {
  Future<HomeDataUser?> getHomeData() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getHomeDataUser();
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
