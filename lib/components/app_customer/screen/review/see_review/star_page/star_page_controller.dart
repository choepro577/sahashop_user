import 'dart:convert';

import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/review.dart';

class StarPageController extends GetxController {
  int? idProductInput;
  String? filterBy;
  String? filterByValue;
  bool? hasImage;

  StarPageController(
      {this.idProductInput, this.filterBy, this.filterByValue, this.hasImage});

  var listReview = RxList<Review>();
  var listImageReviewOfCustomer = RxList<String>([]);
  var isEndReview = false.obs;
  var isLoading = false.obs;
  int currentPage = 1;

  Future<void> getReviewProduct() async {
    isLoading.value = true;
    try {
      var data =
          await CustomerRepositoryManager.reviewRepository.getReviewProduct(
        idProductInput!,
        filterBy!,
        filterByValue!,
        hasImage,
      );

      listReview(data!.data!.data);
      listReview.forEach((review) {
        try {
          listImageReviewOfCustomer(jsonDecode(review.images!));
        } catch (err) {
          listImageReviewOfCustomer([]);
        }
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
