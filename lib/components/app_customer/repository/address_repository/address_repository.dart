import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/address_customer/all_address_customer_response.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/utils/user_info.dart';

class AddressRepository {
  Future<AllIAddressCustomerResponse> getAllAddressCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service
          .getAllAddressCustomer(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
