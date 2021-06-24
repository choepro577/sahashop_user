import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/product.dart';

class CreateMyProgramController extends GetxController {
  var isLoadingCreate = false.obs;
  var listSelectedProduct = RxList<Product>();
  var listProductParam = "";

  Future<void> createDiscount(
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
    isLoadingCreate.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.createDiscount(
          name,
          description,
          imageUrl,
          startTime,
          endTime,
          value,
          setLimitedAmount,
          amount,
          listIdProduct);
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
    listProductParam = "";
  }

  void deleteProduct(int idProduct) {
    listSelectedProduct.removeWhere((product) => product.id == idProduct);
    listSelectedProduct.refresh();
  }

  void listSelectedProductToString() {
    listSelectedProduct.forEach((element) {
      if (element != listSelectedProduct.last) {
        listProductParam = listProductParam + "${element.id.toString()},";
      } else {
        listProductParam = listProductParam + "${element.id.toString()}";
      }
    });
    print(listProductParam);
  }
}
