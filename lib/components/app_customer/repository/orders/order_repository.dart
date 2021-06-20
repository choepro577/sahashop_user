import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/cancel_order_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_history_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_request.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/order_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/orders/state_history_order_customer_response.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/utils/user_info.dart';

class OrderCustomerRepository {
  Future<OrderResponse?> createOrder(OrderRequest orderRequest) async {
    try {
      var res = await CustomerServiceManager().service!.createOrder(
            UserInfo().getCurrentStoreCode(),
            orderRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }

  Future<OrderHistoryResponse?> getOrderHistory(
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
      var res = await CustomerServiceManager().service!.getOrderHistory(
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

  Future<StateHistoryOrderCustomerResponse?> getStateHistoryCustomerOrder(
      int? idOrder) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getStateHistoryCustomerOrder(
              UserInfo().getCurrentStoreCode(), idOrder);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CancelOrderResponse?> cancelOrder(
      String? orderCode, String reasonCancel) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .cancelOrder(UserInfo().getCurrentStoreCode(), {
        "order_code": orderCode,
        "note": reasonCancel,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OrderResponse?> getOneOrderHistory(String? orderCode) async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getOneOrderHistory(UserInfo().getCurrentStoreCode(), orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CancelOrderResponse?> changePaymentMethod(
      String? orderCode, int? paymentMethodId) async {
    try {
      var res = await CustomerServiceManager().service!.changePaymentMethod(
          UserInfo().getCurrentStoreCode(),
          {
            "payment_method_id": paymentMethodId,
          },
          orderCode);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
