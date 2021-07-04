import 'dart:convert';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/review.dart';

class StarPageController extends GetxController {
  int? idProductInput;
  String? filterBy;
  String? filterByValue;
  bool? hasImage;

  StarPageController(
      {this.idProductInput, this.filterBy, this.filterByValue, this.hasImage});

  var listReview = RxList<Review>();
  var listImageReviewOfCustomer = RxList<List<dynamic>>([]);
  var isEndReview = false;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;

  Future<void> getReviewProduct({bool? isLoadMoreCondition}) async {
    if (isLoadMoreCondition == true) {
      isLoadMore.value = true;
    } else {
      isLoading.value = true;
    }
    try {
      if (isEndReview == false) {
        var data = await CustomerRepositoryManager.reviewCustomerRepository
            .getReviewProduct(
          idProductInput!,
          filterBy!,
          filterByValue!,
          hasImage,
        );

        listReview(data!.data!.data);
        listReview.forEach((review) {
          try {
            listImageReviewOfCustomer.add(jsonDecode(review.images!));
          } catch (err) {
            listImageReviewOfCustomer.add([]);
          }
        });

        if (data.data!.nextPageUrl == null) {
          isEndReview = false;
          currentPage++;
        } else {
          isEndReview = true;
        }
        isLoading.value = false;
        isLoadMore.value = false;
      } else {
        isLoadMore.value = false;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
