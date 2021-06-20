import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/info_customer.dart';

class CustomerManageController extends GetxController {
  var listInfoCustomer = RxList<InfoCustomer>();
  var isDoneLoadMore = false.obs;
  var isEndCustomer = false.obs;
  var pageLoadMore = 1;
  var isLoadInit = false.obs;

  CustomerManageController() {
    loadInitOrder();
  }

  Future<void> loadInitOrder() async {
    isLoadInit.value = true;
    pageLoadMore = 1;
    isEndCustomer.value = false;
    loadMoreCustomer();
  }

  Future<void> loadMoreCustomer() async {
    isDoneLoadMore.value = false;
    try {
      if (!isEndCustomer.value) {
        var res = await RepositoryManager.customerRepository
            .getAllInfoCustomer(pageLoadMore);
        listInfoCustomer.addAll(res!.data!.data!);

        if (res.data!.nextPageUrl != null) {
          pageLoadMore++;
          isEndCustomer.value = false;
        } else {
          isEndCustomer.value = true;
        }
      } else {
        isDoneLoadMore.value = true;
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDoneLoadMore.value = true;
    isLoadInit.value = false;
  }
}
