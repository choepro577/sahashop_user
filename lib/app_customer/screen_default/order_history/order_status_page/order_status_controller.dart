import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/order.dart';

class OrderStatusController extends GetxController {
  String? fieldBy;
  String? fieldByValue;

  OrderStatusController({this.fieldBy, this.fieldByValue});

  bool isEndOrder = false;
  int currentPage = 1;
  var isLoadMore = false.obs;
  var isLoadRefresh = true.obs;
  var listOrder = RxList<Order>([]);
  var checkIsEmpty = false.obs;
  var listCheckReviewed = RxList<bool>();

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

  Future<void> getAllOrder({bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listOrder([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    checkIsEmpty.value = false;

    try {
      if (isEndOrder == false) {
        var res = await CustomerRepositoryManager.orderCustomerRepository
            .getOrderHistory(
                currentPage, "", fieldBy!, fieldByValue!, "", "", "", "");

        res!.data!.data!.forEach((element) {
          listOrder.add(element);
          listCheckReviewed.add(true);
        });

        if (listOrder.isEmpty) {
          checkIsEmpty.value = true;
        }
        listOrder.refresh();

        if (res.data!.nextPageUrl != null) {
          currentPage++;
          isEndOrder = false;
        } else {
          isEndOrder = true;
        }
      } else {
        isLoadMore.value = false;
        return;
      }

      if (fieldByValue == COMPLETED) {
        for (int i = 0; i < listOrder.length; i++) {
          var checkReviewed = listOrder[i]
              .lineItems!
              .map((e) => e.reviewed)
              .toList()
              .contains(false);
          if (checkReviewed == true) {
            listCheckReviewed[i] = false;
          }
        }
        print(listCheckReviewed);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadMore.value = false;
    isLoadRefresh.value = false;
  }
}
