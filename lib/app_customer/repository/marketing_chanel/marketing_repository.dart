import 'package:sahashop_user/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/marketing_chanel/combo_customer_response.dart';
import '../../remote/response-request/marketing_chanel/voucher_customer_response.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';

class MarketingRepository {
  Future<CustomerComboResponse?> getComboCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getComboCustomer(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<VoucherCustomerResponse?> getVoucherCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getVoucherCustomer(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
