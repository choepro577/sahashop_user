import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/info_customer/info_customer_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/login/login_response.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/model/info_address.dart';
import 'package:sahashop_user/model/info_customer.dart';
import 'package:sahashop_user/utils/user_info.dart';

class InfoCustomerRepository {
  Future<InfoCustomerResponse> getInfoCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service
          .getInfoCustomer(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }

  Future<InfoCustomerResponse> updateAccountCustomer(
      InfoCustomer infoCustomer) async {
    try {
      var res = await CustomerServiceManager().service.updateAccount(
          UserInfo().getCurrentStoreCode(), infoCustomer.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
