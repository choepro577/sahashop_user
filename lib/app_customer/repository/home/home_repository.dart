import '../../remote/customer_service_manager.dart';
import '../../repository/handle_error.dart';
import 'package:sahashop_user/app_user/model/home_data.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class HomeDataRepository {
  Future<HomeData?> getHomeData() async {
    try {
      var res = await CustomerServiceManager().service!.getHomeApp(
            UserInfo().getCurrentStoreCode(),
          );
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
