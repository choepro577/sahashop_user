import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/data/remote/response-request/product/all_product_response.dart';
import 'package:sahashop_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/data/repository/repository_manager.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/screen/inventory/products/widget/product_page/product_page.dart';

class ProductPageController extends GetxController {
  var loading = false.obs;
  var listProduct = RxList<Product>();
  int currentPage = 1;
  bool isEndLoadMore = false;

   Function? updateTotal;
  String searchText = "";
   TYPE_PAGE? typePage;

  ProductPageController(
      {this.updateTotal,
      this.typePage = TYPE_PAGE.STOCKING}) {

  }

  void updateSuccessProduct(Product product) {
    var index = listProduct.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      listProduct[index] = product;
    }
    getAllProduct(isUpdateTotal: true);
  }

  void showHideProduct(bool hide, Product product) async {
    try {
      ProductRequest productRequest = ProductRequest.fromProduct(product);
      if (hide) {
        productRequest.status = -1;
      } else {
        productRequest.status = 0;
      }
      var res = await RepositoryManager.productRepository
          .update(product.id!, productRequest);

      updateSuccessProduct(res!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> getAllProduct(
      {bool isLoadMore = false,
      bool isRefresh = false,
      bool isUpdateTotal = false,
      String search = ""}) async {
    if (search.length > 0) {
      searchText = search;
    }


    if (isRefresh == true) {
      currentPage = 1;
      isEndLoadMore = false;
    } else if (!isLoadMore && !isUpdateTotal) {
      isEndLoadMore = false;
      loading.value = true;
      currentPage = 1;
    }

    if (isEndLoadMore && !isUpdateTotal) {
      return false;
    }

    try {
      late DataPageProduct data;

      if (this.typePage == TYPE_PAGE.STOCKING) {
        data = (await RepositoryManager.productRepository.getAllProduct(
            search: searchText,
            status: "0",
            filterBy: "quantity_in_stock",
            filterOption: "ne",
            filterByValue: "0",
            page: isLoadMore ? currentPage : 1)) as DataPageProduct;
      }
      if (this.typePage == TYPE_PAGE.OUT_OF_STOCK) {
        data = (await RepositoryManager.productRepository.getAllProduct(
            search: searchText,
            status: "0",
            filterBy: "quantity_in_stock",
            filterOption: "eq",
            filterByValue: "0",
            page: isLoadMore ? currentPage : 1)) as DataPageProduct;
      }
      if (this.typePage == TYPE_PAGE.HIDE) {
        data = (await RepositoryManager.productRepository.getAllProduct(
            search: searchText,
            filterBy: "status",
            filterOption: "ne",
            filterByValue: "0",
            page: isLoadMore ? currentPage : 1)) as DataPageProduct;
      }

      var list = data.data;

      if (isUpdateTotal) {
        updateTotal!(data.totalStoking, data.totalOutOfStock, data.totalHide);
        return true;
      }
      updateTotal!(data.totalStoking, data.totalOutOfStock, data.totalHide);

      if (list!.length < 20) {
        isEndLoadMore = true;
      }
      currentPage++;
      if (isLoadMore == false) {
        listProduct(list);
      } else {
        listProduct.addAll(list);
      }

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> deleteProduct(int idProduct) async {
    try {
      var ok = await RepositoryManager.productRepository.delete(idProduct);
      if (ok!) {
        listProduct.removeWhere((element) => element.id == idProduct);
      }
      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }
}
