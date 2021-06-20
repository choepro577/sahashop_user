import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/divide/divide.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/const/constant_database_status_online.dart';
import 'package:sahashop_user/data/remote/response-request/product/product_request.dart';
import 'package:sahashop_user/model/category.dart';
import 'package:sahashop_user/screen/inventory/attribute/attributes_screen.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/add_product_controller.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'widget/distribute_select.dart';
import 'widget/distribute_select_controller.dart';
import 'widget/select_images_controller.dart';
import 'widget/select_images.dart';

class AddProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingControllerName =
      new TextEditingController();
  final AddProductController addProductController = new AddProductController();

  final DistributeSelectController distributeSelectController =
      Get.put(DistributeSelectController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
            appBar: SahaAppBar(
              titleText: "Thêm sản phẩm",
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
                                    if (value!.length == 0) {
                                      return 'Không được để trống';
                                    }
                                    return null;
                                  },
                                  labelText: "Tên sản phẩm",
                                  hintText: "Nhập tên sản phẩm",
                                ),
                              ),
                              SahaDivide(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SelectProductImages(
                                  onUpload: () {
                                    addProductController
                                        .setUploadingImages(true);
                                  },
                                  doneUpload: (List<ImageData> listImages) {
                                    print(
                                        "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                    addProductController
                                        .setUploadingImages(false);
                                    addProductController.listImages =
                                        listImages;
                                  },
                                ),
                              ),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
                                onChanged: (value) {
                                  addProductController.productRequest.price =
                                      double.tryParse(value!);
                                },
                                validator: (value) {
                                  if (value!.length == 0) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.number,
                                labelText: "Giá",
                                hintText: "Đặt",
                              ),
                              SahaDivide(),
                              Obx(
                                () => addProductController
                                        .isLoadingCategory.value
                                    ? SahaLoadingWidget(
                                        size: 20,
                                      )
                                    : Container(
                                  height: 100,
                                )
                              ),
                              SahaDivide(),
                              InkWell(
                                onTap: () {
                                  Get.to(() => AttributeScreen(
                                        onData: (data) {
                                          addProductController
                                              .setNewListAttribute(data);
                                        },
                                      ));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.ballot_outlined),
                                        Text(
                                          "Quản lý thuộc tính",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16),
                                        ),
                                        Spacer(),
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
                              buildListAttribute(),
                              SahaDivide(),
                              InkWell(
                                onTap: () {
                                  toDistributeEdit();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.auto_awesome_motion),
                                        Text(
                                          "Phân loại sản phẩm",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16),
                                        ),
                                        Spacer(),
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
                              buildListDistribute(),
                              SahaDivide(),
                              SahaTextFieldNoBorder(
                                onChanged: (value) {
                                  addProductController
                                      .productRequest.description = value;
                                },
                                validator: (value) {
                                  if (value!.length == 0) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                labelText: "Mô tả",
                                hintText: "Nhập mô tả sản phẩm",
                              ),
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
                                          if (_formKey.currentState!
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
                                          if (_formKey.currentState!
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

  void toDistributeEdit() {
    Get.to(() => DistributeSelect(
      onData:
          (List<DistributesRequest> data) {
        addProductController
            .setNewListDistribute(
            data.toList());
      },
    ));
  }

  Widget buildListAttribute() {
    return Obx(
      () => Column(
        children: addProductController.listAttribute
            .map((attribute) => Column(
                  children: [
                    Container(
                      height: 1,
                      color: Colors.grey[100],
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 4),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              size: 15,
                            ),
                            Text(attribute),
                            Expanded(
                              child: TextFormField(
                                initialValue: addProductController
                                    .attributeData[attribute],
                                keyboardType: TextInputType.number,
                                validator: (value) {},
                                onChanged: (text) {
                                  addProductController.addValueToMapAttribute(
                                      attribute, text);
                                },
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Đặt"),
                                minLines: 1,
                                maxLines: 1,
                              ),
                            ),
                          ],

                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget buildListDistribute() {
    return GestureDetector(
      onTap: () {
        toDistributeEdit();
      },
      child: Obx(
        () => Column(
          children: addProductController.listDistribute
              .map((distribute) => Column(
                    children: [
                      Container(
                        height: 1,
                        color: Colors.grey[100],
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_box_outlined,
                                      size: 15,
                                    ),
                                    AutoSizeText(distribute.name!)
                                  ],
                                )),
                            Expanded(
                                flex: 7,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: distribute.elementDistributes!
                                          .map((e) => Container(
                                                margin: EdgeInsets.only(right: 4),
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(2),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                alignment: Alignment.center,
                                                height: 60,
                                                child: Row(
                                                  children: [
                                                    e?.imageUrl != null
                                                        ? Container(
                                                            width: 40,
                                                            height: 40,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl:
                                                                  e!.imageUrl!,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Center(
                                                                      child:
                                                                          SahaLoadingWidget()),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                            ),
                                                          )
                                                        : Container(),
                                                    Text(e!.name!),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
