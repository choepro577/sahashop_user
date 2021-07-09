import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/app_user/components/saha_user/picker/category_post/category_post_picker.dart';
import 'package:sahashop_user/app_user/components/saha_user/picker/image/image_dialog_picker.dart';
import 'package:sahashop_user/app_user/components/saha_user/picker/post/post_picker.dart';
import 'package:sahashop_user/app_user/components/saha_user/picker/product/product_picker.dart';
import 'package:sahashop_user/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:sahashop_user/app_user/model/button_home.dart';
import 'package:sahashop_user/app_user/model/category.dart';
import 'package:sahashop_user/app_user/model/category_post.dart';
import 'package:sahashop_user/app_user/model/home_button_config.dart';
import 'package:sahashop_user/app_user/model/post.dart';
import 'package:sahashop_user/app_user/model/product.dart';
import 'package:sahashop_user/app_user/screen/inventory/categories/category_screen.dart';

enum TYPE_ACTION {
  QR,
  SCORE,
  CALL,
  MESSAGE_TO_SHOP,
  VOUCHER,
  PRODUCTS_TOP_SALES,
  PRODUCTS_DISCOUNT,
  PRODUCTS_NEW,
  //////
  LINK,
  PRODUCT,
  CATEGORY_PRODUCT,
  CATEGORY_POST,
  POST,
}

Map mapTypeAction = {
  TYPE_ACTION.QR: "QR",
  TYPE_ACTION.SCORE: "SCORE",
  TYPE_ACTION.CALL: "CALL",
  TYPE_ACTION.MESSAGE_TO_SHOP: "MESSAGE_TO_SHOP",
  TYPE_ACTION.VOUCHER: "VOUCHER",
  TYPE_ACTION.PRODUCTS_TOP_SALES: "PRODUCTS_TOP_SALES",
  TYPE_ACTION.PRODUCTS_DISCOUNT: "PRODUCTS_DISCOUNT",
  TYPE_ACTION.PRODUCTS_NEW: "PRODUCTS_NEW",
  ////
  TYPE_ACTION.LINK: "LINK",
  TYPE_ACTION.PRODUCT: "PRODUCT",
  TYPE_ACTION.CATEGORY_PRODUCT: "CATEGORY_PRODUCT",
  TYPE_ACTION.CATEGORY_POST: "CATEGORY_POST",
  TYPE_ACTION.POST: "POST",
};

class HomeButtonConfigController extends GetxController {
  var checkTypeDefault = [
    TYPE_ACTION.QR,
    TYPE_ACTION.SCORE,
    TYPE_ACTION.CALL,
    TYPE_ACTION.MESSAGE_TO_SHOP,
    TYPE_ACTION.VOUCHER,
    TYPE_ACTION.PRODUCTS_TOP_SALES,
    TYPE_ACTION.PRODUCTS_DISCOUNT,
    TYPE_ACTION.PRODUCTS_NEW,
  ];

  var listButton = [
    TypesButton(name: "Chức năng", listButton: [
      HomeButtonCf(title: "Quét QR", typeAction: mapTypeAction[TYPE_ACTION.QR]),
      HomeButtonCf(
          title: "Gọi điện cho shop",
          typeAction: mapTypeAction[TYPE_ACTION.CALL]),
      HomeButtonCf(
          title: "Nhắn tin cho shop",
          typeAction: mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]),
      HomeButtonCf(
          title: "Tích điểm", typeAction: mapTypeAction[TYPE_ACTION.SCORE]),
      HomeButtonCf(
          title: "Voucher", typeAction: mapTypeAction[TYPE_ACTION.VOUCHER]),
      HomeButtonCf(
          title: "Sản phẩm bán chạy",
          typeAction: mapTypeAction[TYPE_ACTION.PRODUCTS_TOP_SALES]),
      HomeButtonCf(
          title: "Sản phẩm mới",
          typeAction: mapTypeAction[TYPE_ACTION.PRODUCTS_NEW]),
      HomeButtonCf(
          title: "Sản phẩm giảm giá",
          typeAction: mapTypeAction[TYPE_ACTION.PRODUCTS_DISCOUNT]),
    ]),
    TypesButton(name: "Chuyển hướng", listButton: [
      HomeButtonCf(
          title: "Tới trang Web", typeAction: mapTypeAction[TYPE_ACTION.LINK]),
      HomeButtonCf(
          title: "Sản phẩm", typeAction: mapTypeAction[TYPE_ACTION.PRODUCT]),
      HomeButtonCf(
          title: "Danh mục sản phẩm",
          typeAction: mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT]),
      HomeButtonCf(
          title: "Bài viết", typeAction: mapTypeAction[TYPE_ACTION.POST]),
      HomeButtonCf(
          title: "Danh mục bài viết",
          typeAction: mapTypeAction[TYPE_ACTION.CATEGORY_POST]),
    ]),
  ];

  DataAppCustomerController dataAppCustomerController = Get.find();

  var currentButtons = RxList<HomeButton>();
  var currentButtonCfs = RxList<HomeButtonCf>();
  var pageType = 0.obs;

  HomeButtonConfigController() {
    if (dataAppCustomerController.homeData?.buttons != null &&
        dataAppCustomerController.homeData!.buttons!.list!.length > 0)
      buttonToButtonCf(
          currentButtons(dataAppCustomerController.homeData!.buttons!.list));
  }

  bool hasInListShow(HomeButtonCf cf) {
    var lsTypeStr = checkTypeDefault.map((e) => mapTypeAction[e]).toList();
    var lsTypeCurrentStr = currentButtonCfs.map((e) => e.typeAction).toList();

    if (lsTypeStr.contains(cf.typeAction) &&
        lsTypeCurrentStr.contains(cf.typeAction)) {
      return true;
    }

    return false;
  }

  void addButton(HomeButtonCf homeButtonCf) async {
    var newButton = HomeButtonCf(
        title: homeButtonCf.title,
        value: homeButtonCf.value,
        svg: homeButtonCf.svg,
        typeAction: homeButtonCf.typeAction);

    if (hasInListShow(newButton)) {
      SahaAlert.showError(message: "Bạn đã thêm nút này ");
      return;
    }
    if (currentButtonCfs.length == 20) {
      SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
      return;
    }

    var lsTypeStr = checkTypeDefault.map((e) => mapTypeAction[e]).toList();

    if (lsTypeStr.contains(newButton.typeAction)) {
      if (newButton.typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
        await SahaDialogApp.showDialogInput(
            title: "Nhập số điện thoại",
            hintText: "",
            onCancel: () {
              return;
            },
            onInput: (va) {
              if (va.length == 0) {
                SahaAlert.showError(
                    message: "Số điện thoại không được để trống");
                return;
              } else {
                newButton.value = va;
                currentButtonCfs.add(newButton);
              }
            });
      }
      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.LINK]) {
      var stop = false;
      await SahaDialogApp.showDialogInput(
          title: "Tên nút",
          hintText: "",
          onCancel: () {
            stop = true;
            return;
          },
          onInput: (va) {
            if (va.length == 0) {
              SahaAlert.showError(message: "Tên nút không được trống");
              stop = true;
              return;
            } else {
              newButton.title = va;
            }
          });

      if (stop) return;
      await SahaDialogApp.showDialogInput(
          title: "Nhập địa chỉ web",
          hintText: "http://",
          onCancel: () {
            stop = true;
            return;
          },
          onInput: (va) {
            if (GetUtils.isURL(va)) {
              newButton.value = va;
            } else {
              SahaAlert.showError(message: "Địa chỉ không hợp lệ");
              stop = true;
              return;
            }
          });
      if (stop) return;
      ImageDialogPicker.showPickOneImage(onSuccess: (path) {
        newButton.imageUrl = path;

        currentButtonCfs.add(newButton);
      }, onCancel: () {
        return;
      });
      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.PRODUCT]) {
      Get.to(ProductPickerScreen(
        listProductInput: [],
        callback: (List<Product> products) {
          for (var element in products) {
            currentButtonCfs.add(HomeButtonCf(
                title: element.name,
                value: element.id.toString(),
                imageUrl: element.images != null && element.images!.length > 0
                    ? element.images![0].imageUrl
                    : ""));

            if (currentButtonCfs.length == 20) {
              SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
              return;
            }
          }
        },
      ));

      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT]) {
      Get.to(CategoryScreen(
        isSelect: true,
      ))!
          .then((categories) {
        List<Category> categories2 = categories;

        for (var element in categories2) {
          currentButtonCfs.add(HomeButtonCf(
              title: element.name,
              value: element.id.toString(),
              imageUrl: element.imageUrl != null ? element.imageUrl : ""));

          if (currentButtonCfs.length == 20) {
            SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
            return;
          }
        }
      });
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.POST]) {
      Get.to(PostPickerScreen(
        listPostInput: [],
        callback: (List<Post> products) {
          for (var element in products) {
            currentButtonCfs.add(HomeButtonCf(
                title: element.title,
                value: element.id.toString(),
                imageUrl: element.imageUrl != null ? element.imageUrl : ""));

            if (currentButtonCfs.length == 20) {
              SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
              return;
            }
          }
        },
      ));

      return;
    }

    if (newButton.typeAction == mapTypeAction[TYPE_ACTION.CATEGORY_POST]) {
      Get.to(CategoryPostPickerScreen(
        isSelect: true,
      ))!
          .then((categories) {
        List<CategoryPost> categories2 = categories;

        for (var element in categories2) {
          currentButtonCfs.add(HomeButtonCf(
              title: element.title,
              value: element.id.toString(),
              imageUrl: element.imageUrl != null ? element.imageUrl : ""));

          if (currentButtonCfs.length == 20) {
            SahaAlert.showError(message: "Chỉ được thêm tối đã 20 nút");
            return;
          }
        }
      });
    }
  }

  void removeButton(HomeButtonCf homeButtonCf) {
    currentButtonCfs.remove(homeButtonCf);
  }

  void buttonToButtonCf(List<HomeButton>? buttons) {
    if (buttons != null && buttons.length > 0)
      currentButtonCfs(buttons
          .map((e) => HomeButtonCf(
              title: e.title,
              typeAction: e.typeAction,
              imageUrl: e.imageUrl,
              value: e.value,
              svg: ""))
          .toList());
  }

  void changeIndex(int oldIndex, int newIndex) {
    var pre = currentButtonCfs[oldIndex];
    currentButtonCfs.removeAt(oldIndex);
    currentButtonCfs.insert(newIndex, pre);
  }
}

class TypesButton {
  List<HomeButtonCf> listButton = [];
  String name;

  TypesButton({required this.listButton, required this.name});
}
