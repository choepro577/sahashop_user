import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/product.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/product.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_controller.dart';

class AddProductToSaleScreen extends StatefulWidget {
  @override
  _AddProductToSaleScreenState createState() => _AddProductToSaleScreenState();
}

class _AddProductToSaleScreenState extends State<AddProductToSaleScreen> {
  bool isSearch = false;
  //bool isSave = false;

  AddProductToSaleController addProductToSaleController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addProductToSaleController.getAllProduct();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addProductToSaleController.resetListProduct();
    //print(isSave);
    // if (isSave == false) {
    //   addProductToSaleController.listCheckSelectedProduct.value =
    //       addProductToSaleController.listCheckSelectedProductNotSave;
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
          () => addProductToSaleController.isLoadingProduct.value == true
              ? SahaLoadingWidget()
              : Column(
                  children: [
                    ...List.generate(
                      addProductToSaleController.listProduct.length ??
                          LIST_PRODUCT_EXAMPLE.length,
                      (index) => addProductToSaleController
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
                                              value: addProductToSaleController
                                                      .listCheckSelectedProduct
                                                      .value[index]
                                                      .values
                                                      .first ??
                                                  false,
                                              onChanged: (v) {
                                                setState(() {
                                                  addProductToSaleController
                                                      .listCheckSelectedProduct
                                                      .value[index]
                                                      .update(
                                                          addProductToSaleController
                                                              .listCheckSelectedProduct
                                                              .value[index]
                                                              .keys
                                                              .first,
                                                          (value) =>
                                                              !addProductToSaleController
                                                                  .listCheckSelectedProduct
                                                                  .value[index]
                                                                  .values
                                                                  .first);
                                                  print(addProductToSaleController
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
                                                        addProductToSaleController
                                                                    .listProduct[
                                                                        index]
                                                                    .images
                                                                    .length ==
                                                                0
                                                            ? ""
                                                            : addProductToSaleController
                                                                .listProduct[
                                                                    index]
                                                                .images[0]
                                                                .imageUrl,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        height: 100,
                                                        child:
                                                            CachedNetworkImage(
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  addProductToSaleController
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
                                                    "${addProductToSaleController.listProduct[index].price} đ" ??
                                                        "Chưa đặt giá"),
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
                                        "Sản phẩm đã có chương trình giảm giá",
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
                                                color: Colors.grey[200]),
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
                                  Checkbox(
                                      value: addProductToSaleController
                                              .listCheckSelectedProduct
                                              .value[index]
                                              .values
                                              .first ??
                                          false,
                                      onChanged: (v) {
                                        setState(() {
                                          addProductToSaleController
                                              .listCheckSelectedProduct
                                              .value[index]
                                              .update(
                                                  addProductToSaleController
                                                      .listCheckSelectedProduct
                                                      .value[index]
                                                      .keys
                                                      .first,
                                                  (value) =>
                                                      !addProductToSaleController
                                                          .listCheckSelectedProduct
                                                          .value[index]
                                                          .values
                                                          .first);
                                          print(addProductToSaleController
                                              .listCheckSelectedProduct);
                                          addProductToSaleController
                                              .countProductSelected();
                                        });
                                        print(
                                            "check in setState ${addProductToSaleController.listIsSave.value}");
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
                                            imageUrl: addProductToSaleController
                                                        .listProduct[index]
                                                        .images
                                                        .length ==
                                                    0
                                                ? ""
                                                : addProductToSaleController
                                                    .listProduct[index]
                                                    .images[0]
                                                    .imageUrl,
                                            errorWidget:
                                                (context, url, error) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          addProductToSaleController
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
                                            "${addProductToSaleController.listProduct[index].price} đ" ??
                                                "Chưa đặt giá"),
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
                    addProductToSaleController.quantityProductSelected.value
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
                  addProductToSaleController.checkSelectedProduct();
                  addProductToSaleController.checkIsSaveProduct();
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
