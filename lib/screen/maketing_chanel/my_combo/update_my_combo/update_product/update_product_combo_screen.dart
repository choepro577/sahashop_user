import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_combo/update_my_combo/update_product/update_product_combo_controller.dart';

class UpdateProductComboScreen extends StatefulWidget {
  @override
  _UpdateProductComboScreenState createState() =>
      _UpdateProductComboScreenState();
}

class _UpdateProductComboScreenState extends State<UpdateProductComboScreen> {
  bool isSearch = false;
  //bool isSave = false;

  UpdateProductComboController updateProductComboController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateProductComboController.getAllProduct();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    updateProductComboController.resetListProduct();
    //print(isSave);
    // if (isSave == false) {
    //   updateProductComboController.listCheckSelectedProduct.value =
    //       updateProductComboController.listCheckSelectedProductNotSave;
    // }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey[100],
                ),
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  autofocus: true,
                  decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Số lượng (Mặc định: Không giới hạn"),
                  minLines: 1,
                  maxLines: 1,
                ),
              )
            : Text('Thêm sản phẩm '),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (isSearch == false) {
                  setState(() {
                    isSearch = true;
                  });
                } else {
                  setState(() {
                    isSearch = false;
                  });
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => updateProductComboController.isLoadingProduct.value == true
              ? SahaLoadingWidget()
              : Column(
                  children: [
                    ...List.generate(
                      updateProductComboController.listProduct.length,
                      (index) => updateProductComboController
                                  .listIsSave.value[index] ==
                              true
                          ? IgnorePointer(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: 0.4,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                      ),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                              value: updateProductComboController
                                                      .listCheckSelectedProduct
                                                      .value[index]
                                                      .values
                                                      .first,
                                              onChanged: (v) {
                                                setState(() {
                                                  updateProductComboController
                                                      .listCheckSelectedProduct
                                                      .value[index]
                                                      .update(
                                                          updateProductComboController
                                                              .listCheckSelectedProduct
                                                              .value[index]
                                                              .keys
                                                              .first,
                                                          (value) =>
                                                              !updateProductComboController
                                                                  .listCheckSelectedProduct
                                                                  .value[index]
                                                                  .values
                                                                  .first);
                                                  print(updateProductComboController
                                                      .listCheckSelectedProduct);
                                                });
                                              }),
                                          SizedBox(
                                            width: 88,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF5F6F9),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        updateProductComboController
                                                                    .listProduct[
                                                                        index]
                                                                    .images!
                                                                    .length ==
                                                                0
                                                            ? ""
                                                            : updateProductComboController
                                                                .listProduct[
                                                                    index]
                                                                .images![0]
                                                                .imageUrl!,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            SahaEmptyImage(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            width: Get.width * 0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  updateProductComboController
                                                          .listProduct[index]
                                                          .name ??
                                                      "Loi san pham",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                  maxLines: 2,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "${updateProductComboController.listProduct[index].price} đ"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: Get.width * 0.5,
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        "Sản phẩm đã có combo giảm giá",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffff0004),
                                          fontSize: 12,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 10.0,
                                              color: Colors.black12,
                                            ),
                                            Shadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 10.0,
                                                color: Colors.grey[200]!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: updateProductComboController
                                                .listCheckSelectedProduct
                                                .value[index]
                                                .values
                                                .first,
                                        onChanged: (v) {
                                          updateProductComboController
                                              .onChangeCheckbox(index);
                                          print(updateProductComboController
                                              .listCheckSelectedProduct);
                                          updateProductComboController
                                              .countProductSelected();
                                          print(
                                              "check in setState ${updateProductComboController.listIsSave.value}");
                                        }),
                                  ),
                                  SizedBox(
                                    width: 88,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F6F9),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: updateProductComboController
                                                        .listProduct[index]
                                                        .images!
                                                        .length ==
                                                    0
                                                ? ""
                                                : updateProductComboController
                                                    .listProduct[index]
                                                    .images![0]
                                                    .imageUrl!,
                                            errorWidget:
                                                (context, url, error) =>
                                                    SahaEmptyImage(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    width: Get.width * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          updateProductComboController
                                                  .listProduct[index].name ??
                                              "Loi san pham",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "${updateProductComboController.listProduct[index].price} đ"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    updateProductComboController.quantityProductSelected.value
                        .toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Đã Chọn'),
                ],
              ),
              InkWell(
                onTap: () {
                  updateProductComboController.checkSelectedProduct();
                  updateProductComboController.checkIsSaveProduct();
                  updateProductComboController
                      .listSelectedProductToComboProduct();
                  Get.back();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: Text('Thêm'),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
