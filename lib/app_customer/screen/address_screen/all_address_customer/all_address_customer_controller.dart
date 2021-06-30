import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/info_address_customer.dart';

class AllAddressCustomerController extends GetxController {
  var listInfoAddressCustomer = RxList<InfoAddressCustomer>();
  var isLoadingAddress = false.obs;

  AllAddressCustomerController() {
    getAllAddressCustomer();
  }

  Future<void> getAllAddressCustomer() async {
    isLoadingAddress.value = true;
    try {
      var res = await CustomerRepositoryManager.addressRepository
          .getAllAddressCustomer();
      listInfoAddressCustomer(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }
}
