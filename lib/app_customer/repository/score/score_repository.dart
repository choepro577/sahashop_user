import 'package:sahashop_user/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/app_customer/remote/response-request/score/check_in_response.dart';
import 'package:sahashop_user/app_customer/remote/response-request/score/history_score_response.dart';
import 'package:sahashop_user/app_customer/remote/response-request/score/roll_call_response.dart';
import 'package:sahashop_user/app_customer/utils/store_info.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';

class ScoreRepository {
  Future<RollCallsResponse?> getRollCall() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getRollCall(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CheckInResponse?> checkIn() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .checkIn(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<HistoryScoreResponse?> getScoreHistory() async {
    try {
      var res = await CustomerServiceManager()
          .service!
          .getScoreHistory(StoreInfo().getCustomerStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
