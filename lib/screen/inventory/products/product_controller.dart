import 'package:get/get.dart';

import 'widget/product_page/product_page_controller.dart';

class ProductsController extends GetxController {
  var totalStoking = 0.obs;
  var totalOutOfStock= 0.obs;
  var totalHide= 0.obs;
  var searching = false.obs;

  List<ProductPageController> listControllerPage = [];


  void updateTotal({int? totalStokingI, int? totalOutOfStockI, int? totalHideI}) {
    if(totalStokingI != null) {
      totalStoking(totalStokingI);
    }
    if(totalOutOfStockI != null) {
      totalOutOfStock(totalOutOfStockI);
    }
    if(totalHideI != null) {
      totalHide(totalHideI);
    }
  }

  void onSearch(String text){
    listControllerPage.forEach((element) {
      element.searchText = text;
      element.getAllProduct(search: text);
    });
  }

  void closeSearch(){
    listControllerPage.forEach((element) {
      element.searchText = "";
      element.getAllProduct(search: "");
    });
  }

  void addPageController(ProductPageController pageController) {
    if(listControllerPage.contains(pageController)) return;
    listControllerPage.add(pageController);
  }
}