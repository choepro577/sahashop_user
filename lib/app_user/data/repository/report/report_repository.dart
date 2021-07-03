import 'package:sahashop_user/app_user/data/remote/response-request/report/product_report_response.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/report/report_response.dart';
import 'package:sahashop_user/app_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';
import 'package:sahashop_user/app_user/utils/user_info.dart';

class ReportRepository {
  Future<ReportResponse?> getReport(
    String timeFrom,
    String timeTo,
    String dateFromCompare,
    String dateToCompare,
  ) async {
    try {
      var res = await SahaServiceManager().service!.getReport(
          UserInfo().getCurrentStoreCode()!,
          timeFrom,
          timeTo,
          dateFromCompare,
          dateToCompare);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ProductReportResponse?> getProductReport(
    String timeFrom,
    String timeTo,
  ) async {
    try {
      var res = await SahaServiceManager().service!.getProductReport(
            UserInfo().getCurrentStoreCode()!,
            timeFrom,
            timeTo,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}