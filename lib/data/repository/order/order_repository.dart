import 'package:sahashop_user/data/remote/response-request/order/all_order_response.dart';
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
}
