import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response/orders/order_response.dart';
import 'package:sahashop_user/components/app_customer/repository/handle_error.dart';
import 'package:sahashop_user/model/order_request.dart';
import 'package:sahashop_user/utils/user_info.dart';

class OrderCustomerRepository {
  Future<DataOrderResponse> createOrder(OrderRequest orderRequest) async {
    try {
      var res = await CustomerServiceManager().service.createOrder(
            UserInfo().getCurrentStoreCode(),
            orderRequest.toJson(),
          );
      return res.data;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }
}
