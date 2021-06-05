import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/config_profile_screen/config_profile_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/login/login_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/register/register_customer_screen.dart';

class ProfileScreen extends StatelessWidget {
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Container(
                height: 185,
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        dataAppCustomerController.isLogin.value == true
                            ? IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1
                                      .color,
                                ),
                                onPressed: () {})
                            : Container(),
                        IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color,
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(
                              Icons.chat,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                    dataAppCustomerController.isLogin.value == true
                        ? Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => ConfigProfileScreen(
                                        infoCustomer: dataAppCustomerController
                                            .infoCustomer.value,
                                      ));
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  child: ClipRRect(
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        CachedNetworkImage(
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                          imageUrl: dataAppCustomerController
                                                  .infoCustomer
                                                  .value
                                                  .avatarImage ??
                                              "",
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "assets/saha_loading.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        dataAppCustomerController.infoCustomer
                                                    .value.avatarImage ==
                                                null
                                            ? Positioned(
                                                bottom: 1,
                                                child: Container(
                                                  height: 20,
                                                  width: 100,
                                                  color: Colors.black45,
                                                  child: Center(
                                                      child: Text(
                                                    "Sửa",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headline6
                                                            .color),
                                                  )),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(3000),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataAppCustomerController
                                            .infoCustomer.value.name ??
                                        "Chưa có tên",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Thành viên Bạch kim",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 13),
                                        ),
                                        Container(
                                            height: 10,
                                            width: 10,
                                            child: SvgPicture.asset(
                                              "assets/icons/right_arrow.svg",
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F6F9),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => LoginScreenCustomer(),
                                          ).then((value) => {
                                                dataAppCustomerController
                                                    .getInfoCustomer()
                                              });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Đăng nhập",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => RegisterCustomerScreen())
                                              .then((value) => {
                                                    dataAppCustomerController
                                                        .getInfoCustomer()
                                                  });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headline6
                                                      .color)),
                                          child: Center(
                                              child: Text(
                                            "Đăng ký",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline6
                                                    .color),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/check_list.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Đơn mua",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Xem lịch xử mua hàng",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                        Container(
                            height: 13,
                            width: 13,
                            child: SvgPicture.asset(
                              "assets/icons/right_arrow.svg",
                              color: Colors.black,
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              dataAppCustomerController.isLogin.value == true
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  "assets/icons/wallet.svg",
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Chờ xác nhận",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[700]),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  "assets/icons/box.svg",
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Chờ lấy hàng",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[700]),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  "assets/icons/delivery_truck.svg",
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Đang giao",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[700]),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: SvgPicture.asset(
                                  "assets/icons/favorite.svg",
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Đánh giá",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/group.svg",
                            color: Colors.indigo,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mã giới thiệu",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Giới thiệu bạn bè tham gia và nhận phần thưởng",
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[700]),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 8,
                color: Colors.grey[100],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/wallet.svg",
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Ví tích điểm",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "1000 Point",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                        Container(
                            height: 13,
                            width: 13,
                            child: SvgPicture.asset(
                              "assets/icons/right_arrow.svg",
                              color: Colors.black,
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/handbag.svg",
                            color: Colors.indigo,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Mua lại",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/coupon.svg",
                            color: Colors.deepOrange,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Ví Voucher",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/star.svg",
                            color: Colors.greenAccent,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Đánh giá của tôi",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/heart.svg",
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Đã thích",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/location.svg",
                            color: Colors.lightBlue,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Địa chỉ của tôi",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/question_around.svg",
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Trung tâm trợ giúp",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            shape: BoxShape.circle,
                          ),
                          child:
                              SvgPicture.asset("assets/icons/facebook-2.svg"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Fanpage SahaTech",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
