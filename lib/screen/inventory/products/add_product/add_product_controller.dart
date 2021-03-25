import 'package:get/get.dart';
import 'package:sahashop_user/data/remote/product/model/product_request.dart';
import 'package:sahashop_user/data/remote/remote_manager.dart';

class AddProductController extends GetxController {
  ProductRequest productRequest = new ProductRequest();
  var isLoadingAdd = false.obs;


  Future<bool> createProduct() async {
    isLoadingAdd.value = true;
    try {
      var data = await RemoteManager.productService.create(productRequest:productRequest);

      print(data);

      return true;
    } catch (err) {

      return false;
    }
    isLoadingAdd.value = false;
  }

}