import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';

class SeeReviewController extends GetxController {
  final int? idProductInput;

  SeeReviewController({this.idProductInput}) {
    getReviewProduct("", "", null);
  }

  var totalReview = 0.obs;
  var totalHasImage = 0.obs;
  var listStarOneToFive = RxList<int>();
  var currentIndexReview = 0.obs;
  var isLoading = false.obs;

  void changeIndexReview(int indexReview) {
    currentIndexReview.value = indexReview;
    print(currentIndexReview.value);
  }

  Future<void> getReviewProduct(
    String filterBy,
    String filterByValue,
    bool? hasImage,
  ) async {
    isLoading.value = true;
    try {
      var data = await CustomerRepositoryManager.reviewCustomerRepository
          .getReviewProduct(
        idProductInput!,
        filterBy,
        filterByValue,
        hasImage,
      );
      totalReview.value = data!.data!.totalReviews!;
      totalHasImage.value = data.data!.totalHasImage!;
      listStarOneToFive.add(data.data!.totalOneStar!);
      listStarOneToFive.add(data.data!.totalTwoStar!);
      listStarOneToFive.add(data.data!.totalThreeStar!);
      listStarOneToFive.add(data.data!.totalFourStar!);
      listStarOneToFive.add(data.data!.totalFiveStar!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
