import 'package:sahashop_user/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../repository/handle_error.dart';
import 'package:sahashop_user/app_user/model/home_data.dart';

class HomeDataRepository {
  Future<HomeData?> getHomeData() async {
    try {
      var res = await CustomerServiceManager().service!.getHomeApp(
            StoreInfo().getCustomerStoreCode(),
          );
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
