import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/model/combo.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class ProductController extends GetxController {
  var currentIndexListOrder = 0.obs;
  var currentImage = 0.obs;
  var isSeeMore = false.obs;
  var animateAddCart = false.obs;
  var productInput = Product();
  var productShow = Product().obs;
  var listProductsDiscount = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listProductCombo = RxList<ProductsCombo>();
  var hasInCombo = false.obs;
  var discountComboType = 0.obs;
  var valueComboType = 0.0.obs;


  DataAppCustomerController dataAppCustomerController = Get.find();

  ProductController() {
    productInput = dataAppCustomerController.productCurrent;
    productShow.value = dataAppCustomerController.productCurrent;
    getDetailProduct();
    getComboCustomer();
    if (dataAppCustomerController.homeData?.discountProducts?.list != null) {
      dataAppCustomerController.homeData!.discountProducts!.list!
          .forEach((listDiscount) {
        listProductsDiscount.addAll(listDiscount.products!);
      });
    }
  }

  Future<void> getDetailProduct() async {
    isLoadingProduct.value = true;
    try {
      var res = await CustomerRepositoryManager.productCustomerRepository
          .getDetailProduct(productInput.id);
      productShow.value = res!.data ?? productInput;
    } catch (err) {
      //  SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
  }

  Future<void> getComboCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      res!.data!.forEach((e) {
        int checkHasInCombo = e.productsCombo!.indexWhere(
            (element) => element.product!.id == productShow.value.id);
        if (checkHasInCombo != -1) {
          hasInCombo.value = true;

          /// 0 Co dinh, 1 theo %,
          discountComboType.value = e.discountType!;
          valueComboType.value = e.valueDiscount!.toDouble();
          listProductCombo(e.productsCombo!);
        }
      });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void animatedAddCard() {
    animateAddCart.value = true;
    print(animateAddCart.value);
    Future.delayed(Duration(milliseconds: 1000), () {
      animateAddCart.value = false;
      print(animateAddCart.value);
    });
  }

  void changeIndexImage(int value) {
    currentImage.value = value;
  }

  void onchangeSeeMore() {
    isSeeMore.value = !isSeeMore.value;
  }

  void addItemCart() {
    dataAppCustomerController.addItemCart(productShow.value.id);
  }

  void addManyItemOrUpdate(
      {int? quantity,
      bool? buyNow,
      List<DistributesSelected>? distributesSelected,
      int? productId}) {
    dataAppCustomerController.updateItemCart(
        productId, quantity!, distributesSelected!.toList());

    Get.back();
    if (buyNow == true) {
      Get.to(() => CartScreen1());
    }
  }

}
