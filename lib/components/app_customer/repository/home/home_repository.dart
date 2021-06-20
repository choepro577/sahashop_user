import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/model/home_data.dart';
import 'package:sahashop_user/utils/user_info.dart';

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
