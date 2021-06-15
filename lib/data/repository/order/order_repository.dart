import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_response.dart';
import 'package:sahashop_user/data/remote/response-request/order/all_order_response.dart';
import 'package:sahashop_user/data/remote/response-request/order/change_order_status_repose.dart';
import 'package:sahashop_user/data/remote/response-request/order/state_history_order_response.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/utils/user_info.dart';

class OrderRepository {
  Future<AllOrderResponse> getAllOrder(
    int numberPage,
    String search,
    String fieldBy,
    String fieldByValue,
    String sortBy,
    String descending,
    String dateFrom,
    String dateTo,
  ) async {
    try {
      var res = await SahaServiceManager().service.getAllOrder(
          UserInfo().getCurrentStoreCode(),
          numberPage,
          search,
          fieldBy,
          fieldByValue,
          sortBy,
          descending,
          dateFrom,
          dateTo);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<StateHistoryOrderResponse> getStateHistoryOrder(int idOrder) async {
    try {
      var res = await SahaServiceManager()
          .service
          .getStateHistoryOrder(UserInfo().getCurrentStoreCode(), idOrder);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderResponse> getOneOrder(String orderCode) async {
    try {
      var res = await SahaServiceManager()
          .service
          .getOneOrder(UserInfo().getCurrentStoreCode(), orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ChangeOrderStatusResponse> changeOrderStatus(
      String orderCode, String orderStatusCode) async {
    try {
      var res = await SahaServiceManager()
          .service
          .changeOrderStatus(UserInfo().getCurrentStoreCode(), {
        "order_code": orderCode,
        "order_status_code": orderStatusCode,
      });
    } catch (err) {
      handleError(err);
    }
  }
}
