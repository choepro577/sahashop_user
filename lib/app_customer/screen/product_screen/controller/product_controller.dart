import 'dart:convert';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/repository/repository_customer.dart';
import 'package:sahashop_user/app_customer/screen/cart_screen/cart_controller.dart';
import 'package:sahashop_user/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/app_user/data/example/product.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/combo.dart';
import 'package:sahashop_user/app_user/model/order.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'package:sahashop_user/app_user/model/review.dart';

import '../../data_app_controller.dart';

class ProductController extends GetxController {
  var currentIndexListOrder = 0.obs;
  var currentImage = 0.obs;
  var isSeeMore = false.obs;
  var animateAddCart = false.obs;
  Product? productInput;
  var productShow = Product().obs;
  var listProductsDiscount = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listProductCombo = RxList<ProductsCombo>();
  var hasInCombo = false.obs;
  var discountComboType = 0.obs;
  var valueComboType = 0.0.obs;
  var averagedStars = 0.0.obs;
  var totalReview = 0.obs;
  var listReview = RxList<Review>();
  var listImageReviewOfCustomer = RxList<List<dynamic>>([]);
  var listAllImageReview = RxList<String>();

  DataAppCustomerController dataAppCustomerController = Get.find();
  CartController cartController = Get.find();

  ProductController() {
    productInput = dataAppCustomerController.productCurrent;
    if (productInput == null) {
      productShow.value = EXAMPLE_LIST_PRODUCT[0];
    } else {
      productShow.value = dataAppCustomerController.productCurrent!;
      getDetailProduct();
      getComboCustomer();
      getReviewProduct();
      if (dataAppCustomerController.homeData?.discountProducts?.list != null) {
        dataAppCustomerController.homeData!.discountProducts!.list!
            .forEach((listDiscount) {
          listProductsDiscount.addAll(listDiscount.products!);
        });
      }
    }
  }

  Future<void> getDetailProduct() async {
    isLoadingProduct.value = true;
    try {
      var res = await CustomerRepositoryManager.productCustomerRepository
          .getDetailProduct(productInput!.id ?? 0);
      productShow.value = res!.data ?? productInput!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingProduct.value = false;
  }

  Future<void> favoriteProduct(bool isFavorite) async {
    try {
      var res = await CustomerRepositoryManager.favoriteRepository
          .favoriteProduct(productInput!.id ?? 0, isFavorite);
      if (isFavorite) {
        productShow.value.isFavorite = true;
        productShow.refresh();
        SahaAlert.showSuccess(message: "Đã thích");
      } else {
        productShow.value.isFavorite = false;
        productShow.refresh();
        SahaAlert.showSuccess(message: "Đã bỏ thích");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
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

  Future<void> getReviewProduct() async {
    try {
      var data = await CustomerRepositoryManager.reviewCustomerRepository
          .getReviewProduct(
        productInput!.id ?? 0,
        "",
        "",
        null,
      );
      averagedStars.value = data!.data!.averagedStars!;
      totalReview.value = data.data!.totalReviews!;
      listReview(data.data!.data);
      listReview.forEach((review) {
        try {
          listImageReviewOfCustomer.add(jsonDecode(review.images!));
        } catch (err) {
          listImageReviewOfCustomer.add([]);
        }
      });
      listImageReviewOfCustomer.forEach((listImage) {
        listImage.forEach((imageLink) {
          listAllImageReview.add(imageLink);
        });
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
    cartController.addItemCart(productShow.value.id);
  }

  Future<void> addManyItemOrUpdate(
      {int? quantity,
      bool? buyNow,
      List<DistributesSelected>? distributesSelected,
      int? productId}) async {
    var index = cartController.listOrder
        .indexWhere((element) => element.product!.id == productId);

    if (index != -1) {
      await cartController.updateItemCart(
          productId,
          cartController.listQuantityProduct[index] + quantity!,
          distributesSelected!.toList());
    } else {
      await cartController.updateItemCart(
          productId, quantity!, distributesSelected!.toList());
    }

    Get.back();
    if (buyNow == true) {
      Get.to(() => CartScreen1());
    }
  }
}
