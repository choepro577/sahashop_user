import 'package:sahashop_user/data/remote/response/create_discount_response/create_discount_respone.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/utils/user_info.dart';
import '../handle_error.dart';

class MarketingChanelRepository {
  Future<CreateDiscountResponse> createDiscount(
    String name,
    String description,
    String imageUrl,
    String startTime,
    String endTime,
    int value,
    bool setLimitedAmount,
    int amount,
    String listIdProduct,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service
          .createDiscount(UserInfo().getCurrentStoreCode(), {
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "value": value,
        "set_limit_amount": setLimitedAmount,
        "amount": amount,
        "product_ids": listIdProduct,
      });

      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
