import 'package:sahashop_user/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/app_customer/remote/response-request/shipment/shipment_response.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class ShipmentRepository {
  Future<ShipmentCustomerResponse?> chargeShipmentFee(
      int? idAddressCustomer) async {
    try {
      var res = await CustomerServiceManager().service!.chargeShipmentFee(
          UserInfo().getCurrentStoreCode(),
          {"id_address_customer": idAddressCustomer});
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}