import 'dart:convert';

import 'package:get/get.dart';
import '../../repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/screen/inventory/products/add_product/widget/select_images_controller.dart';

class ReviewController extends GetxController {
  final List<LineItemsAtTime>? lineItemsAtTimeInput;
  final String? orderCodeInput;
  ReviewController({this.lineItemsAtTimeInput, this.orderCodeInput}) {
    lineItemsAtTimeInput!.forEach((item) {
      listStar.add(5);
      listContent.add("");
      listImageRequest!.add([]);
      listImages!.add([]);
    });
  }

  List<String> listChooseText = [
    "Chất lượng sản phẩm tuyệt vời",
    "Đóng gói sản phẩm rất đẹp",
    "Shop phục vụ rất tốt",
    "Rất đáng tiền",
    "Thời gian giao hàng nhanh",
  ];

  var listStar = RxList<int?>();
  var listContent = RxList<String?>();
  List<List<String>>? listImageRequest = [];
  List<List<ImageData>>? listImages = [];

  var uploadingImages = false.obs;

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  Future<void> reviewAllOrder() async {
    for (int i = 0; i < lineItemsAtTimeInput!.length; i++) {
      await reviewProduct(
          lineItemsAtTimeInput![i].id!,
          orderCodeInput!,
          listStar[i]!,
          listContent[i]!,
          jsonEncode(listImageRequest![i]).toString());
    }
    SahaAlert.showToastMiddle(message: "Đánh giá thành công");
    Get.back();
  }

  Future<void> reviewProduct(
    int idProduct,
    String orderCode,
    int star,
    String content,
    String images,
  ) async {
    try {
      var data = await CustomerRepositoryManager.reviewCustomerRepository
          .review(idProduct, orderCode, star, content, images);
    } catch (err) {
      print("ssss");
      SahaAlert.showError(message: err.toString());
    }
  }
}
