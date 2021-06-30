import 'package:get/get.dart';
import 'package:sahashop_user/app_user/screen/inventory/products/widget/product_page/product_page.dart';

import 'widget/product_page/product_page_controller.dart';

class ProductsController extends GetxController {
  var totalStoking = 0.obs;
  var totalOutOfStock= 0.obs;
  var totalHide= 0.obs;
  var searching = false.obs;

  Map<TYPE_PAGE, ProductPageController> pagesController
   ={};


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
    pagesController.values.forEach((element) {
      element.searchText = text;
      element.getAllProduct(search: text);
    });
  }

  void closeSearch(){
    pagesController.values.forEach((element) {
      element.searchText = "";
      element.getAllProduct(search: "");
    });
  }
  void addPageController(ProductPageController pageController, TYPE_PAGE typePage) {
    var listType = pagesController.values.map((e) => e.typePage).toList();

      pagesController[typePage] = pageController;


  }
}