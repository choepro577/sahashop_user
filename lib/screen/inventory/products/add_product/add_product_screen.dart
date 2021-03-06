import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/divide/divide.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/components/saha_user/sahashopTextField.dart';
import 'package:sahashop_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/const/constant_database_status_online.dart';
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
        child: Scaffold(
            appBar: SahaAppBar(
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
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SahaTextFieldNoBorder(
                                  withAsterisk: true,
                                  onChanged: (value) {
                                    addProductController.productRequest.name =
                                        value;
                                  },
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return 'Không được để trống';
                                    }
                                    return null;
                                  },
                                  labelText: "Tên sản phẩm",
                                  hintText: "Nhập tên sản phẩm",
                                ),
                              ),
                              SahaDivide(),
                              SelectProductImages(
                                onUpload: () {
                                  addProductController.setUploadingImages(true);
                                },
                                doneUpload: (List<ImageData> listImages) {
                                  print(
                                      "done upload image ${listImages?.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                  addProductController
                                      .setUploadingImages(false);
                                  addProductController.listImages = listImages;
                                },
                              ),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
                                onChanged: (value) {
                                  addProductController
                                      .productRequest.description = value;
                                },
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                labelText: "Mô tả",
                                hintText: "Nhập mô tả sản phẩm",
                              ),
                              SahaDivide(),
                              Obx(
                                () => addProductController
                                        .isLoadingCategory.value
                                    ? SahaLoadingWidget(
                                        size: 20,
                                      )
                                    : SmartSelect<Category>.multiple(
                                        title: 'Danh mục',
                                        value: addProductController
                                            .listCategorySelected
                                            .toList(),
                                        modalHeader: true,
                                        modalFilter: true,
                                        modalType: S2ModalType.bottomSheet,
                                        modalFilterHint: "",
                                        choiceConfig: S2ChoiceConfig(),
                                        choiceGroupBuilder:
                                            (context, header, choices) {
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
                                              chipLength:
                                                  state.valueObject.length,
                                              chipLabelBuilder: (context, i) {
                                                return Text(
                                                    state.valueObject[i].title);
                                              },
                                              chipAvatarBuilder: (context, i) {
                                                return CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(state
                                                                .valueObject[i]
                                                                .value
                                                                ?.imageUrl ??
                                                            ""));
                                              },
                                              chipOnDelete: (i) {
                                                addProductController
                                                    .onRemoveItem(state
                                                        .valueObject[i].value);
                                              },
                                              chipColor: SahaPrimaryColor,
                                              chipBrightness: Brightness.dark,
                                              chipBorderOpacity: .5,
                                            ),
                                          );
                                        },
                                        choiceItems: addProductController
                                            .listCategory
                                            .toList()
                                            .map(
                                              (category) => S2Choice<Category>(
                                                  value: category,
                                                  title: category.name),
                                            )
                                            .toList(),
                                        onChange: (state) {
                                          addProductController
                                              .onChoose(state.value);
                                        }),
                              ),
                              SahaDivide(),
                              InkWell(
                                onTap: () {
                                  Get.to(() => DetailSelect(
                                        onData: (data) {
                                          addProductController
                                              .productRequest.details = data;
                                        },
                                      ));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Phân loại sản phẩm",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
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
                                hintText: "Đặt",
                              ),
                              SahaDivide(),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => Row(
                            children: [
                              Expanded(
                                child: SahaButtonFullParent(
                                  color: Colors.white,
                                  textColor: Colors.black87,
                                  colorBorder: Colors.grey[500],
                                  text: "Lưu tạm",
                                  onPressed: !addProductController
                                          .uploadingImages.value
                                      ? () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            addProductController.productRequest
                                                .status = STATUS_PRODUCT_HIDE;
                                            addProductController
                                                .createProduct();
                                          }
                                        }
                                      : null,
                                ),
                              ),
                              Expanded(
                                child: SahaButtonFullParent(
                                  text: "Hiển thị",
                                  onPressed: !addProductController
                                          .uploadingImages.value
                                      ? () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            addProductController.productRequest
                                                .status = STATUS_PRODUCT_SHOW;
                                            addProductController
                                                .createProduct();
                                          }
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
                Obx(() {
                  return (addProductController.isLoadingAdd.value)
                      ? SahaLoadingFullScreen()
                      : Container();
                })
              ],
            )),
      ),
    );
  }
}
