import 'package:get/get.dart';
import '../../repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/order.dart';

class OrderCompletedController extends GetxController {
  final String? orderCode;

  Rx<Order?> order = Order().obs;
  var loading = false.obs;
  var isLoadingPayment = false.obs;
  var refreshValue = false.obs;
  RxList<Map<int, String>>? listPaymentMethod = RxList<Map<int, String>>();
  Map<int, String> paymentMethod = {};

  OrderCompletedController(this.orderCode) {
    loadOrder(orderCode);
    loadPaymentMethod();
  }

  Future<void> loadOrder(String? orderCode) async {
    loading.value = false;
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getOneOrderHistory(orderCode);

      order.value = res!.data;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> loadPaymentMethod() async {
    isLoadingPayment.value = true;
    try {
      var res =
          await CustomerRepositoryManager.paymentRepository.getPaymentMethod();
      res!.data!.forEach((element) {
        listPaymentMethod!.add({element["id"]: element["name"]});
      });

      print(listPaymentMethod);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingPayment.value = false;
  }

  Future<void> changPaymentMethod(int? idPayment) async {
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .changePaymentMethod(orderCode, idPayment);
      refreshData();
      refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void refresh() {
    refreshValue.value = !refreshValue.value;
  }

  Future<void> refreshData() async {
    loadOrder(orderCode);
  }
}
