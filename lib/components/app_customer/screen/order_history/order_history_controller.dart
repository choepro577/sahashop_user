import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/order.dart';

class OrderHistoryController extends GetxController {
  var listOrder = RxList<Order>();
  var pageLoadMore = 1;
  var isEndPageVoucher = false;
  var isDoneLoadMore = false;
  var listStatusCode = [
    WAITING_FOR_PROGRESSING,
    PACKING,
    SHIPPING,
    COMPLETED,
    OUT_OF_STOCK,
    USER_CANCELLED,
    CUSTOMER_CANCELLED,
    DELIVERY_ERROR,
    CUSTOMER_RETURNING,
    CUSTOMER_HAS_RETURNS,
  ];

  void loadInitOrder() {
    pageLoadMore = 1;
    isEndPageVoucher = false;
    loadMoreOrder();
  }

  Future<void> loadMoreOrder() async {
    isDoneLoadMore = false;
    try {
      if (!isEndPageVoucher) {
        var res = await CustomerRepositoryManager.orderCustomerRepository
            .getOrderHistory(pageLoadMore, "", "", "", "", "", "", "");
        listOrder.addAll(res.data.data);
        if (res.data.nextPageUrl != null) {
          pageLoadMore++;
          isEndPageVoucher = false;
        } else {
          isEndPageVoucher = true;
        }
      } else {
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDoneLoadMore = true;
  }

  Future<void> refreshData() async {
    listOrder([]);
    loadInitOrder();
  }
}
