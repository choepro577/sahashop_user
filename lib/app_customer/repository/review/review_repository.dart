import 'package:sahashop_user/app_customer/utils/store_info.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/review/review_of_product_response.dart';
import '../../remote/response-request/review/review_response.dart';
import 'package:sahashop_user/app_user/data/repository/handle_error.dart';

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
          StoreInfo().getCustomerStoreCode(), idProduct, {
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
          StoreInfo().getCustomerStoreCode(),
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
