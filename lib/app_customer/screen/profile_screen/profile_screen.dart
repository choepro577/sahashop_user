import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/screen/address_screen/all_address_customer/all_address_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen/cart_screen/cart_screen_1.dart';
import 'package:sahashop_user/app_customer/screen/choose_voucher/choose_voucher_customer_screen.dart';
import 'package:sahashop_user/app_customer/screen/config_profile_screen/config_profile_screen.dart';
import 'package:sahashop_user/app_customer/screen/favorites/favorites.dart';
import 'package:sahashop_user/app_customer/screen/login/login_screen.dart';
import 'package:sahashop_user/app_customer/screen/order_history/order_history_screen.dart';
import 'package:sahashop_user/app_customer/screen/register/register_customer_screen.dart';
import 'package:sahashop_user/app_customer/utils/color_utils.dart';
import 'package:sahashop_user/app_customer/utils/customer_info.dart';
import 'package:sahashop_user/app_user/components/saha_user/dialog/dialog.dart';

import '../data_app_controller.dart';
import 'fanpage/fanpage_screen.dart';
import 'profile_controller.dart';


// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  DataAppCustomerController dataAppCustomerController = Get.find();
  ProfileController profileController = ProfileController();
  @override
  Widget build(BuildContext context) {
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
                              Icons.settings_outlined,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
                                  .color,
                            ),
                            onPressed: () {})
                            : Container(),
                        InkWell(
                          onTap: () {
                            Get.to(() => CartScreen1());
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                  onPressed: () {
                                    Get.to(() => CartScreen1());
                                  }),
                              if (dataAppCustomerController.listOrder.length !=
                                  0)
                                Positioned(
                                  top: 5,
                                  right: 2,
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF4848),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5, color: Colors.white),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${dataAppCustomerController.listOrder.length}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          height: 1,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.chat_outlined,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
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
                              infoCustomer:
                              dataAppCustomerController
                                  .infoCustomer.value,
                            ))!
                                .then((value) => {
                              dataAppCustomerController
                                  .getInfoCustomer()
                            });
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Colors.grey[200]!)),
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
                                        .value!
                                        .avatarImage ??
                                        "",
                                    errorWidget: (context, url, error) =>
                                        SahaEmptyImage(),
                                  ),
                                  dataAppCustomerController.infoCustomer
                                      .value!.avatarImage !=
                                      null
                                      ? Positioned(
                                    bottom: 1,
                                    child: Container(
                                      height: 20,
                                      width: 100,
                                      color: Colors.black45
                                          .withOpacity(0.3),
                                      child: Center(
                                        child: Text(
                                          "Sửa",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  )
                                      : SahaEmptyImage(),
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
                                  .infoCustomer.value!.name ??
                                  "Chưa có tên",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6!
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
                                    )!
                                        .then((value) => {
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
                                    Get.to(() =>
                                        RegisterCustomerScreen())!
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
                                                .headline6!
                                                .color!)),
                                    child: Center(
                                        child: Text(
                                          "Đăng ký",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline6!
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
              InkWell(
                onTap: () {
                  Get.to(() => OrderHistoryScreen());
                },
                child: Padding(
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
                              color:
                              SahaColorUtils().colorTextWithPrimaryColor(),
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
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
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
              ),
              Divider(
                height: 1,
              ),
              dataAppCustomerController.isLogin.value == true
                  ? Obx(
                    () => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => OrderHistoryScreen(
                                initPage: 0,
                              ));
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    "assets/icons/wallet.svg",
                                    color: SahaColorUtils()
                                        .colorTextWithPrimaryColor(),
                                  ),
                                ),
                                profileController
                                    .processingAmount.value !=
                                    0
                                    ? Positioned(
                                  top: -3,
                                  right: -5,
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF4848),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5,
                                          color: Colors.white),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${profileController.processingAmount.value}+",
                                        style: TextStyle(
                                          fontSize: 8,
                                          height: 1,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ],
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
                          InkWell(
                            onTap: () {
                              Get.to(() => OrderHistoryScreen(
                                initPage: 1,
                              ));
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    "assets/icons/box.svg",
                                    color: SahaColorUtils()
                                        .colorTextWithPrimaryColor(),
                                  ),
                                ),
                                profileController.packingAmount.value != 0
                                    ? Positioned(
                                  top: -3,
                                  right: -5,
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF4848),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5,
                                          color: Colors.white),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${profileController.packingAmount.value}+",
                                        style: TextStyle(
                                          fontSize: 8,
                                          height: 1,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ],
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
                          InkWell(
                            onTap: () {
                              Get.to(() => OrderHistoryScreen(
                                initPage: 2,
                              ));
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    "assets/icons/delivery_truck.svg",
                                    color: SahaColorUtils()
                                        .colorTextWithPrimaryColor(),
                                  ),
                                ),
                                profileController.shippingAmount.value !=
                                    0
                                    ? Positioned(
                                  top: -3,
                                  right: -5,
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF4848),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5,
                                          color: Colors.white),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${profileController.shippingAmount.value}+",
                                        style: TextStyle(
                                          fontSize: 8,
                                          height: 1,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ],
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
                          InkWell(
                            onTap: () {
                              Get.to(() => OrderHistoryScreen(
                                initPage: 3,
                              ));
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  child: SvgPicture.asset(
                                    "assets/icons/favorite.svg",
                                    color: SahaColorUtils()
                                        .colorTextWithPrimaryColor(),
                                  ),
                                ),
                                profileController.evaluateAmount.value !=
                                    0
                                    ? Positioned(
                                  top: -8,
                                  right: -8,
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF4848),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5,
                                          color: Colors.white),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${profileController.evaluateAmount.value}+",
                                        style: TextStyle(
                                          fontSize: 8,
                                          height: 1,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ],
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
              InkWell(
                onTap: () {
                  Get.to(() => ChooseVoucherCustomerScreen());
                },
                child: Padding(
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
              ),
              Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => FavoritesScreen());
                },
                child: Padding(
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
              ),
              Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => AllAddressCustomerScreen());
                },
                child: Padding(
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
              InkWell(
                onTap: () {
                  Get.to(() => FanPageScreen());
                },
                child: Padding(
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
              ),
              Divider(
                height: 1,
              ),
              dataAppCustomerController.isLogin.value == true
                  ? InkWell(
                onTap: () {
                  SahaDialogApp.showDialogYesNo(
                      mess: "Bạn muốn đăng xuất",
                      onOK: () {
                        CustomerInfo().logout();
                      });
                },
                child: Padding(
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
                            SvgPicture.asset("assets/svg/logout.svg"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Đăng xuất",
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
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}