import 'dart:convert';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/app_user/model/review.dart';


import '../review_manage_controller.dart';

class StarPageManageController extends GetxController {
  String? filterBy;
  String? filterByValue;
  bool? hasImage;

  StarPageManageController({this.filterBy, this.filterByValue, this.hasImage});

  var listReview = RxList<Review>();
  var listImageReviewOfCustomer = RxList<List<dynamic>>([]);
  var isEndReview = false;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;

  ReviewManagerController reviewManagerController = Get.find();

  Future<void> getReviewProduct({bool? isLoadMoreCondition}) async {
    if (isLoadMoreCondition == true) {
      isLoadMore.value = true;
    } else {
      isLoading.value = true;
    }
    try {
      if (isEndReview == false) {
        var data = await RepositoryManager.reviewRepository.getReviewManage(
          filterBy!,
          filterByValue!,
        );

        listReview(data!.data!.data);
        listReview.forEach((review) {
          try {
            listImageReviewOfCustomer.add(jsonDecode(review.images!));
          } catch (err) {
            listImageReviewOfCustomer.add([]);
          }
        });
        print(listImageReviewOfCustomer);

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

  void refreshData() {
    isEndReview = false;
    currentPage = 1;
    listReview([]);
    listImageReviewOfCustomer([]);
    getReviewProduct(isLoadMoreCondition: false);
    reviewManagerController.getReviewProduct();
  }

  Future<void> deleteReview(int idReview) async {
    try {
      var res = await RepositoryManager.reviewRepository.deleteReview(idReview);
      refreshData();
      SahaAlert.showToastMiddle(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateReview(int idReview) async {
    try {
      var res = await RepositoryManager.reviewRepository
          .updateReview(idReview, 1); // 1 is accept review show
      refreshData();
      SahaAlert.showToastMiddle(message: "Duyệt thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}