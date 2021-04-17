import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/components/saha_user/sahashopTextField.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/add_product_controller.dart';
import 'package:smart_select/smart_select.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'widget/detail_select.dart';
import 'widget/detail_select_controller.dart';
import 'widget/select_images_controller.dart';
import 'widget/select_images.dart';

class AddProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingControllerName =
      new TextEditingController();
  final AddProductController addProductController = new AddProductController();

  final DetailSelectController detailSelectController =
      Get.put(DetailSelectController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text("Thêm sản phẩm"),
                    actions: [
                      InkWell(
                        onTap: () {
                          addProductController.createProduct();
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Thêm"),
                          ),
                        ),
                      )
                    ],
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: Text("Thông tin chính")),
                        Tab(icon: Text("Thuộc tính")),
                        Tab(icon: Text("Nâng cao")),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      tab1(),
                      DetailSelect(),
                      Icon(Icons.directions_bike),
                    ],
                  )),
            ),
            Obx(() {
              return (addProductController.isLoadingAdd.value)
                  ? SahaLoadingFullScreen()
                  : Container();
            })
          ],
        ),
      ),
    );
  }

  Widget tab1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SahaTextField(
                    onChanged: (value) {
                      addProductController.productRequest.name = value;
                    },
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Tên sản phẩm",
                    hintText: "Mời nhập tên sản phẩm",
                  ),
                  SelectProductImages(
                    onUpload: () {
                      addProductController.setUploadingImages(true);
                    },
                    doneUpload: (List<ImageData> listImages) {
                      print(
                          "done upload image ${listImages?.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                      addProductController.setUploadingImages(false);
                      addProductController.listImages = listImages;
                    },
                  ),
                  Obx(
                    () => addProductController.isLoadingCategory.value
                        ? SahaLoadingWidget(
                            size: 20,
                          )
                        : SmartSelect<Category>.multiple(
                            title: 'Danh mục',
                            value: addProductController.listCategorySelected
                                .toList(),
                            modalHeader: true,
                            modalFilter: true,
                            modalType: S2ModalType.bottomSheet,
                            modalFilterHint: "",
                            choiceConfig: S2ChoiceConfig(),
                            choiceGroupBuilder: (context, header, choices) {
                              return StickyHeader(
                                header: header,
                                content: choices,
                              );
                            },
                            tileBuilder: (context, state) {
                              return S2Tile.fromState(
                                state,
                                hideValue: true,
                                body: S2TileChips(
                                  chipLength: state.valueObject.length,
                                  chipLabelBuilder: (context, i) {
                                    return Text(state.valueObject[i].title);
                                  },
                                  chipAvatarBuilder: (context, i) {
                                    return CircleAvatar(
                                        backgroundImage: NetworkImage(state
                                                .valueObject[i]
                                                .value
                                                ?.imageUrl ??
                                            ""));
                                  },
                                  chipOnDelete: (i) {
                                    addProductController.onRemoveItem(
                                        state.valueObject[i].value);
                                  },
                                  chipColor: SahaPrimaryColor,
                                  chipBrightness: Brightness.dark,
                                  chipBorderOpacity: .5,
                                ),
                              );
                            },
                            choiceItems: addProductController.listCategory
                                .toList()
                                .map(
                                  (category) => S2Choice<Category>(
                                      value: category, title: category.name),
                                )
                                .toList(),
                            onChange: (state) {
                              addProductController.onChoose(state.value);
                            }),
                  ),
                  SahaTextField(
                    onChanged: (value) {
                      addProductController.productRequest.description = value;
                    },
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    labelText: "Mô tả",
                    hintText: "Mời nhập mô tả sản phẩm",
                  ),
                  SahaTextField(
                    onChanged: (value) {
                      addProductController.productRequest.price =
                          int.tryParse(value);
                    },
                    validator: (value) {
                      if (value.length == 0) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                    textInputType: TextInputType.number,
                    labelText: "Giá",
                    hintText: "Mời nhập mô tả sản phẩm",
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => SahaButtonFullParent(
              text: addProductController.uploadingImages.value
                  ? "Đang up ảnh..."
                  : "Thêm",
              onPressed: !addProductController.uploadingImages.value
                  ? () {
                      if (_formKey.currentState.validate()) {
                        addProductController.createProduct();
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
