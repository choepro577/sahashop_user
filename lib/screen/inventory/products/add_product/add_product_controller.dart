import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/repository/product/product_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';

class AddProductController extends GetxController {
  ProductRequest productRequest = new ProductRequest();
  var isLoadingAdd = false.obs;

  Future<void> createProduct() async {
    isLoadingAdd.value = true;
    try {
      var data =
          await RepositoryManager.productRepository.create(productRequest);


      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
