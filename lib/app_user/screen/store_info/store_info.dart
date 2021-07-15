import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/app_user/screen/home/choose_store/choose_store.dart';
import 'package:sahashop_user/app_user/screen/home/home_controller.dart';
import 'package:sahashop_user/app_user/screen/register_app/expired/expired_screen.dart';
import 'package:sahashop_user/app_user/utils/date_utils.dart';

import 'change_store_info_screen/change_store_info_screen.dart';
import 'store_info_controller.dart';

class StoreInfoScreen extends StatelessWidget {
  HomeController homeController = Get.find();
  StoreInfoController storeInfoController = StoreInfoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cửa hàng"),
        actions: [],
      ),
      body: Obx(() {
        Store store = homeController.storeCurrent!.value;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[200]!)),
                        child: ClipRRect(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CachedNetworkImage(
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                imageUrl: store.logoUrl ?? "",
                                errorWidget: (context, url, error) =>
                                    SahaEmptyImage(),
                              ),

                            ],
                          ),
                          borderRadius: BorderRadius.circular(3000),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${store.name}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                          ),



                          InkWell(
                              onTap: () {
                                Get.to(ChangeStoreInfoScreen())!.then((value) {
                                  homeController.onHandleAfterChangeStore();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 5,right: 5),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mã cửa hàng: ${store.storeCode}",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Chỉnh sửa",
                                        style:
                                            TextStyle(color: Colors.blue, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Get.to(ChooseStoreScreen())!.then((value) {
                              homeController.onHandleAfterChangeStore();
                            });
                          },
                          child: Text(
                            "Chuyển \n cửa hàng",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.teal, fontSize: 12),
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      "HẠN SỬ DỤNG",
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Ngày hết hạn: ${SahaDateUtils().getDDMMYY2(homeController.getDateTimeExpired())}",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    )
                  ],
                ),
              ),
              Container(
                height: 100,
                color: Colors.white,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeController.checkExpired() == ExpiredEnum.ExpiryDate
                        ? Text(
                            "Cửa hàng của bạn còn ${homeController.getDayExpired()} ngày sử dụng")
                        : Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              "Cửa hàng của bạn đã hết hạn sử dụng hãy gia hạn để dùng đầy đủ chức năng",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => ExpiredScreen());
                            },
                            child: Text("Gia hạn")))
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "TỔNG QUAN CỬA HÀNG",
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10, right: 10, left: 5),
                  child: Column(
                    children: [
                      buildListItem(
                          "Tổng sản phẩm", "${store.totalProducts ?? ""}",
                       Icon(Ionicons.layers_outline,
                          color: SahaPrimaryColor,
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      buildListItem("Tổng danh mục sản phẩm",
                          "${store.totalProductCategories ?? ""}",
                        Icon(Ionicons.grid_outline,
                          color: SahaPrimaryColor,
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      buildListItem(
                          "Tổng bài viết", "${store.totalPosts ?? ""}",
                        Icon(Ionicons.newspaper_outline,
                          color: SahaPrimaryColor,
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      buildListItem("Tổng danh mục bài viết",
                          "${store.totalPostCategories ?? ""}",
                        Icon(Ionicons.library_outline,
                          color: SahaPrimaryColor,
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      buildListItem(
                          "Tổng khách hàng", "${store.totalCustomers ?? ""}",
                        Icon(Ionicons.person_outline,
                          color: SahaPrimaryColor,
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      buildListItem(
                          "Tổng số đơn hàng", "${store.totalOrders ?? ""}",
                        Icon(Ionicons.reader_outline,
                          color: SahaPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  int? totalProducts;
  int? totalProductCategories;
  int? totalPosts;
  int? totalPostCategories;
  int? totalCustomers;
  int? totalOrders;
  Widget buildListItem(String title, String value, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(title),
          Spacer(),
          Text(
            value,
            style: TextStyle(color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
