import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/app_user/screen/home/home_controller.dart';

class StoreInfoScreen extends StatelessWidget {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    Store store = homeController.storeCurrent!.value;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cửa hàng"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      imageUrl: store.logoUrl ?? "",
                      errorWidget: (context, url, error) => Container(
                            height: 70,
                            width: 70,
                            child: ClipOval(
                              child: SahaEmptyImage(),
                            ),
                          )),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${store.name}" , style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Mã cửa hàng: ${store.storeCode}",
                           style: TextStyle(
                          color: Colors.grey
                      ),),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("HẠN SỬ DỤNG", style: TextStyle(
              color: Colors.teal,

            ),),
          ),
          Container(
            height: 100,
            color: Colors.white,
            child: Center(child: Text("Cửa hàng của bạn còn 150 ngày")),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("TỔNG QUAN CỬA HÀNG", style: TextStyle(
              color: Colors.teal,

            ),),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  buildListItem("Tổng sản phẩm", "${store.totalProducts ?? ""}"),
                  Divider(height: 1,),
                  buildListItem("Tổng danh mục sản phẩm", "${store.totalProductCategories?? ""}"),
                  Divider(height: 1,),
                  buildListItem("Tổng bài viết", "${store.totalPosts?? ""}"),
                  Divider(height: 1,),
                  buildListItem("Tổng danh mục bài viết", "${store.totalPostCategories?? ""}"),
                  Divider(height: 1,),
                  buildListItem("Tổng khách hàng", "${store.totalCustomers?? ""}"),
                  Divider(height: 1,),
                  buildListItem("Tổng số đơn hàng", "${store.totalOrders?? ""}"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  int? totalProducts;
  int? totalProductCategories;
  int? totalPosts;
  int? totalPostCategories;
  int? totalCustomers;
  int? totalOrders;
  Widget buildListItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text(title),
          Spacer(),
          Text(value, style: TextStyle(
            color: Colors.teal
          ),),
        ],
      ),
    );
  }
}
