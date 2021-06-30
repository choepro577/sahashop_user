import 'package:get/get.dart';
import '../../repository/handle_error.dart';
import '../../repository/repository_customer.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/product.dart';


class FavoritesController extends GetxController {
  var isLoadingProduct = true.obs;
  bool isEndLoadMore = false;
  int currentPage = 1;

  var products = RxList<Product>();

  FavoritesController() {
    getProducts();
  }

  @override
  void onInit() {
    super.onInit();

  }

  Future<void> getProducts({bool isLoadMore = false,
    bool isRefresh = false,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEndLoadMore = false;
    } else if (!isLoadMore) {
      isEndLoadMore = false;
      isLoadingProduct.value = true;
      currentPage = 1;
    }

    if (isEndLoadMore) {
      return;
    }

    try {
      var res =
          await CustomerRepositoryManager.favoriteRepository.getAllFavorite(
              page: isLoadMore ? currentPage : 1
          );
      var list = res!.data!.data;


      if (list!.length < 20) {
        isEndLoadMore = true;
      }
      currentPage++;
      if (isLoadMore == false) {
        products(list);
      } else {
        products.addAll(list);
      }

    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
  }
}
