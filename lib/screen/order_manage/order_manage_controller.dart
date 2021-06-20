import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/order.dart';

class OrderManageController extends GetxController {
  // var listOrder = RxList<Order>();

  List<bool> listIsEndOrder = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<int> listPageLoadMore = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  var isDoneLoadMore = false.obs;
  var isLoadInit = true.obs;
  var listAllOrder =
      RxList<List<Order>>([[], [], [], [], [], [], [], [], [], []]);
  var listCheckIsEmpty = RxList<bool>(
      [false, false, false, false, false, false, false, false, false, false]);

  var listCheckRefresh = RxList<int>([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
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

  Future<void> loadInitOrder(
      String fieldBy, String fieldByValue, int indexStatus) async {
    isLoadInit.value = true;
    listPageLoadMore[indexStatus] = 1;
    listIsEndOrder[indexStatus] = false;
    loadMoreOrder(fieldBy, fieldByValue, indexStatus);
  }

  Future<void> loadMoreOrder(
      String fieldBy, String fieldByValue, int indexStatus) async {
    isDoneLoadMore.value = false;
    listCheckIsEmpty[indexStatus] = false;
    try {
      if (!listIsEndOrder[indexStatus]) {
        var res = await RepositoryManager.orderRepository.getAllOrder(
            listPageLoadMore[indexStatus],
            "",
            fieldBy,
            fieldByValue,
            "",
            "",
            "",
            "");

        res!.data!.data!.forEach((element) {
          listAllOrder[indexStatus].add(element);
        });

        if (listAllOrder[indexStatus].isEmpty) {
          listCheckIsEmpty[indexStatus] = true;
        }

        listCheckRefresh[indexStatus]++;
        listAllOrder.refresh();

        if (res.data!.nextPageUrl != null) {
          listPageLoadMore[indexStatus]++;
          listIsEndOrder[indexStatus] = false;
        } else {
          listIsEndOrder[indexStatus] = true;
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

  Future<void> refreshData(
      String fieldBy, String fieldByValue, int indexStatus) async {
    isLoadInit.value = true;
    listAllOrder[indexStatus] = [];
    loadInitOrder(fieldBy, fieldByValue, indexStatus);
  }
}
