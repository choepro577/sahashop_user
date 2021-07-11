import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/home_buttons/list_home_button_controller.dart';
import 'package:sahashop_user/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/category_post_screen/category_post_screen_1.dart';
import 'package:sahashop_user/app_customer/screen_default/category_post_screen/read_post_screen/input_model_post.dart';
import 'package:sahashop_user/app_customer/screen_default/category_post_screen/read_post_screen/read_post_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/chat_customer/chat_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/choose_voucher/choose_voucher_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/member/member_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/qr_screen/qr_screen.dart';
import 'package:sahashop_user/app_customer/screen_default/web_view/web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionTap {
  static void onTap(String? typeAction, String? value) {

    if (typeAction == mapTypeAction[TYPE_ACTION.QR]) {
      Get.to(() => QRScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
      launch("tel:$value");
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.SCORE]) {
      Get.to(() => MemberScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]) {
      Get.to(() => ChatCustomerScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_TOP_SALES]) {
      Get.to(CategoryProductScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_DISCOUNT]) {
      Get.to(CategoryProductScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_NEW]) {
      Get.to(CategoryProductScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.VOUCHER]) {
      Get.to(() => ChooseVoucherCustomerScreen());
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.LINK]) {
      Get.to(() => WebViewScreen(link: value,));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCT]) {
      Get.to(ProductScreen(
        productId: int.tryParse(value!) ?? -1,
      ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT]) {
      Get.to(CategoryProductScreen(
        categoryId: int.tryParse(value!) ?? -1,
      ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.POST]) {
      Get.to(() => ReadPostScreen(
        inputModelPost: InputModelPost(
          postId: int.tryParse(value!) ?? -1,
        ),
      ));
    }

    if (typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_POST]) {
      Get.to(() => CategoryPostScreen(
        categoryId: int.tryParse(value!) ?? -1,
      ));
    }
  }
}
