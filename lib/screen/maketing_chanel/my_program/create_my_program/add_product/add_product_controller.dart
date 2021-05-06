import 'package:get/get.dart';
import 'package:sahashop_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_user/data/repository/handle_error.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/utils/user_info.dart';

class AddProductToSaleController extends GetxController {
  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;

  Future<List<Product>> getAllProduct(
      {String search,
      String idCategory,
      bool descending,
      String details,
      String sortBy}) async {
    isLoadingProduct.value = true;
    try {
      var res = await SahaServiceManager().service.getAllProduct(
          UserInfo().getCurrentStoreCode(),
          search ?? "",
          idCategory ?? "",
          descending ?? false,
          details ?? "",
          sortBy ?? "");
      listProduct.addAll(res.data.data);
      print(listProduct);
      isLoadingProduct.value = false;
      return res.data.data;
    } catch (err) {
      handleError(err);
    }
    isLoadingProduct.value = false;
  }
}
