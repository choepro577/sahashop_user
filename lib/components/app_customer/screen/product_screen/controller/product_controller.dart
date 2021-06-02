import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/components/app_customer/screen/cart_screen_type/cart_screen_1.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/components/utils/storage_order.dart';
import 'package:sahashop_user/model/combo.dart';
import 'package:sahashop_user/model/order.dart';
import 'package:sahashop_user/model/product.dart';

class ProductController extends GetxController {
  var quantity = 1.obs;
  var currentIndexListOrder = 0.obs;
  var currentImage = 0.obs;
  var isSeeMore = false.obs;
  var animateAddCart = false.obs;
  var currentProduct = Product();
  var productDetailRequest = Product().obs;
  var listProductsDiscount = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listProductCombo = RxList<ProductsCombo>();
  var hasInCombo = false.obs;

  DataAppCustomerController dataAppCustomerController = Get.find();

  ProductController() {
    currentProduct =
        dataAppCustomerController.productCurrent ?? LIST_PRODUCT_EXAMPLE;
    getDetailProduct();
    getComboCustomer();
    if (dataAppCustomerController.homeData?.discountProducts?.list != null) {
      dataAppCustomerController.homeData.discountProducts.list
          .forEach((listDiscount) {
        listProductsDiscount.addAll(listDiscount.products);
      });
    }
  }

  Future<void> getDetailProduct() async {
    isLoadingProduct.value = true;
    try {
      var res = await CustomerRepositoryManager.productCustomerRepository
          .getDetailProduct(currentProduct.id);
      productDetailRequest.value = res.data ?? currentProduct;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
  }

  Future<void> getComboCustomer() async {
    try {
      var res = await CustomerRepositoryManager.marketingRepository
          .getComboCustomer();
      res.data.forEach((e) {
        int checkHasInCombo = e.productsCombo.indexWhere(
            (element) => element.product.id == productDetailRequest.value.id);
        if (checkHasInCombo != -1) {
          hasInCombo.value = true;
        }
        listProductCombo(e.productsCombo);
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

  void increaseItem() {
    quantity = quantity + 1;
  }

  void decreaseItem() {
    if (quantity > 1) {
      quantity = quantity - 1;
    } else {
      return;
    }
  }

  void addOrder() {
    var order =
        Order(product: productDetailRequest.value, quantity: quantity.value);

    int idCurrent = dataAppCustomerController.listOrder.indexWhere(
        (element) => element.product.id == productDetailRequest.value.id);

    print(idCurrent);

    if (idCurrent != -1) {
      var orderUpdate = Order(
          product: productDetailRequest.value,
          quantity: dataAppCustomerController.listOrder[idCurrent].quantity +
              quantity.value);
      StorageOrder.updateOrder(orderUpdate, idCurrent);
      dataAppCustomerController.getListOrder();

      /// back sheet
      Get.back();
      Get.to(() => CartScreen1());
    } else {
      StorageOrder.addOrder(order);
      dataAppCustomerController.getListOrder();

      /// back sheet
      Get.back();
      Get.to(() => CartScreen1());
    }
  }

  void addOneItem() {
    var order =
        Order(product: productDetailRequest.value, quantity: quantity.value);

    int idCurrent = dataAppCustomerController.listOrder.indexWhere(
        (element) => element.product.id == productDetailRequest.value.id);

    print(idCurrent);

    if (idCurrent != -1) {
      var orderUpdate = Order(
          product: productDetailRequest.value,
          quantity:
              dataAppCustomerController.listOrder[idCurrent].quantity + 1);
      StorageOrder.updateOrder(orderUpdate, idCurrent);
      dataAppCustomerController.getListOrder();
    } else {
      StorageOrder.addOrder(order);
      dataAppCustomerController.getListOrder();
    }
  }
}
