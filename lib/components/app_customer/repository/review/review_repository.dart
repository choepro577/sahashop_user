import 'package:sahashop_user/components/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/review/review_of_product_response.dart';
import 'package:sahashop_user/components/app_customer/remote/response-request/review/review_response.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/utils/user_info.dart';

class ReviewCustomerRepository {
  Future<ReviewResponse?> review(
    int idProduct,
    String orderCode,
    int star,
    String content,
    String images,
  ) async {
    try {
      var res = CustomerServiceManager().service!.review(
          UserInfo().getCurrentStoreCode(), idProduct, {
        "order_code": orderCode,
        "stars": star,
        "content": content,
        "images": images
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ReviewOfProResponse?> getReviewProduct(int idProduct, String filterBy,
      String filterByValue, bool? hasImage) async {
    try {
      var res = await CustomerServiceManager().service!.getReviewProduct(
          UserInfo().getCurrentStoreCode(),
          idProduct,
          filterBy,
          filterByValue,
          hasImage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
