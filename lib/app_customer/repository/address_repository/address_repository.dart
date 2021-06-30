import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/address_customer/address_customer_request.dart';
import '../../remote/response-request/address_customer/all_address_customer_response.dart';
import '../../remote/response-request/address_customer/create_update_address_customer_response.dart';
import '../../remote/response-request/address_customer/delete_address_customer_response.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class AddressRepository {
  Future<AllIAddressCustomerResponse?> getAllAddressCustomer() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getAllAddressCustomer(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<CreateUpdateAddressCustomerResponse?> createAddressCustomer(
      AddressCustomerRequest addressCustomerRequest) async {
    try {
      var res = await CustomerServiceManager().service!.createAddressCustomer(
          UserInfo().getCurrentStoreCode(), addressCustomerRequest.toJson());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
     throw(err.toString());
    }
  }

  Future<CreateUpdateAddressCustomerResponse> updateAddressCustomer(
      int? idAddressCustomer,
      AddressCustomerRequest addressCustomerRequest) async {
    try {
      var res = await CustomerServiceManager().service!.updateAddressCustomer(
          UserInfo().getCurrentStoreCode(),
          idAddressCustomer,
          addressCustomerRequest.toJson());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      throw(err.toString());
    }
  }

  Future<DeleteAddressCustomerResponse?> deleteAddressCustomer(
      int? idAddressCustomer) async {
    try {
      var res = await CustomerServiceManager().service!.deleteAddressCustomer(
          UserInfo().getCurrentStoreCode(), idAddressCustomer);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
