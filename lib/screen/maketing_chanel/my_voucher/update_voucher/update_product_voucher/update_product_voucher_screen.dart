import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/create_my_voucher/add_product_to_voucher/add_product_voucher_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/update_voucher/update_product_voucher/update_product_voucher_controller.dart';

class UpdateProductToVoucherScreen extends StatefulWidget {
  @override
  _UpdateProductToVoucherScreenState createState() =>
      _UpdateProductToVoucherScreenState();
}

class _UpdateProductToVoucherScreenState
    extends State<UpdateProductToVoucherScreen> {
  bool isSearch = false;
  //bool isSave = false;

  UpdateProductVoucherController updateProductToSaleController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateProductToSaleController.getAllProduct();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    updateProductToSaleController.resetListProduct();
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
          () => updateProductToSaleController.isLoadingProduct.value == true
              ? SahaLoadingWidget()
              : Column(
                  children: [
                    ...List.generate(
                      updateProductToSaleController.listProduct.length,
                      (index) => Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                                value: updateProductToSaleController
                                        .listCheckSelectedProduct
                                        .value[index]
                                        .values
                                        .first,
                                onChanged: (v) {
                                  setState(() {
                                    updateProductToSaleController
                                        .listCheckSelectedProduct.value[index]
                                        .update(
                                            updateProductToSaleController
                                                .listCheckSelectedProduct
                                                .value[index]
                                                .keys
                                                .first,
                                            (value) =>
                                                !updateProductToSaleController
                                                    .listCheckSelectedProduct
                                                    .value[index]
                                                    .values
                                                    .first);
                                    print(updateProductToSaleController
                                        .listCheckSelectedProduct);
                                    updateProductToSaleController
                                        .countProductSelected();
                                  });
                                  print(
                                      "check in setState ${updateProductToSaleController.listIsSave.value}");
                                }),
                            SizedBox(
                              width: 88,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: updateProductToSaleController
                                                  .listProduct[index]
                                                  .images!
                                                  .length ==
                                              0
                                          ? ""
                                          : updateProductToSaleController
                                              .listProduct[index]
                                              .images![0]
                                              .imageUrl!,
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 100,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: Get.width * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    updateProductToSaleController
                                            .listProduct[index].name ??
                                        "Loi san pham",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "${updateProductToSaleController.listProduct[index].price ?? ""} đ"),
                                ],
                              ),
                            )
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
                    updateProductToSaleController.quantityProductSelected.value
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
                  updateProductToSaleController.checkSelectedProduct();
                  updateProductToSaleController.checkIsSaveProduct();
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
