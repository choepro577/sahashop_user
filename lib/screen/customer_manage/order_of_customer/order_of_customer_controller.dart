import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/order.dart';

class OrderOfCustomerController extends GetxController {
  var listOrder = RxList<Order>();
  var isDoneLoadMore = false.obs;
  var isEndCustomer = false.obs;
  var pageLoadMore = 1;
  var isLoadInit = false.obs;

  Future<void> loadInitOrder(int idCustomer) async {
    isLoadInit.value = true;
    pageLoadMore = 1;
    isEndCustomer.value = false;
    loadMoreCustomer(idCustomer);
  }

  Future<void> loadMoreCustomer(int idCustomer) async {
    isDoneLoadMore.value = false;
    try {
      if (!isEndCustomer.value) {
        var res = await RepositoryManager.orderRepository.getAllOrder(
            pageLoadMore, "", "customer_id", "$idCustomer", "", "", "", "");

        listOrder.addAll(res.data.data);

        if (res.data.nextPageUrl != null) {
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
