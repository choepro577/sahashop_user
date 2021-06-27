import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/address_screen/all_address_customer/all_address_customer_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/choose_voucher/choose_voucher_customer_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/favorites/favorites.dart';
import 'package:sahashop_user/components/app_customer/screen/profile_screen/fanpage/fanpage_screen.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/dialog/dialog.dart';
import 'package:sahashop_user/utils/user_info.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: SahaAppBar(
          titleText: "Tài khoản",
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  SahaDialogApp.showDialogYesNo(mess: "Bạn muốn đăng xuất",
                  onOK: () {
                    UserInfo().logout();
                  }
                  );
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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

            ],
          ),
        ),
      ),
    );
  }
}
