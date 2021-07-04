import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/screen_default/address_screen/choose_address_customer_screen/choose_address_customer_screen.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:sahashop_user/app_user/const/type_address.dart';
import 'package:sahashop_user/app_user/model/info_address_customer.dart';
import 'package:sahashop_user/app_user/model/location_address.dart';

import 'config_address_customer_controller.dart';

class ConfigAddressCustomerScreen extends StatelessWidget {
  final InfoAddressCustomer? infoAddressCustomer;

  late ConfigAddressCustomerController configAddressCustomerController;
  ConfigAddressCustomerScreen({this.infoAddressCustomer}) {
    configAddressCustomerController = ConfigAddressCustomerController(
      infoAddressCustomer: infoAddressCustomer,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa địa chỉ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Họ và tên"),
                  Container(
                    width: Get.width * 0.5,
                    height: 25,
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      controller: configAddressCustomerController
                          .nameTextEditingController.value,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Số điện thoại"),
                  Container(
                    height: 25,
                    width: Get.width * 0.5,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 14),
                      controller: configAddressCustomerController
                          .phoneTextEditingController.value,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 1,
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
                Get.to(() => ChooseAddressCustomerScreen(
                      typeAddress: TypeAddress.Province,
                      callback: (LocationAddress location) {
                        configAddressCustomerController.locationProvince.value =
                            location;
                        configAddressCustomerController.locationDistrict.value =
                            new LocationAddress();
                        configAddressCustomerController.locationWard.value =
                            new LocationAddress();
                      },
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tỉnh/Thành phố"),
                    Row(
                      children: [
                        Obx(() => Text(
                            "${configAddressCustomerController.locationProvince.value.name ?? "Chưa chọn Tỉnh/Thành phố"}")),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                Get.to(() => ChooseAddressCustomerScreen(
                      typeAddress: TypeAddress.District,
                      idProvince: configAddressCustomerController
                          .locationProvince.value.id,
                      callback: (LocationAddress location) {
                        configAddressCustomerController.locationDistrict.value =
                            location;
                      },
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quận/Huyện"),
                    Row(
                      children: [
                        Obx(
                          () => Text(
                              "${configAddressCustomerController.locationDistrict.value.name ?? "Chưa chọn Quận/Huyện"}"),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                Get.to(() => ChooseAddressCustomerScreen(
                      typeAddress: TypeAddress.Wards,
                      idDistrict: configAddressCustomerController
                          .locationDistrict.value.id,
                      callback: (LocationAddress location) {
                        configAddressCustomerController.locationWard.value =
                            location;
                      },
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phường/Xã"),
                    Row(
                      children: [
                        Obx(
                          () => Text(
                              "${configAddressCustomerController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Địa chỉ cụ thể"),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Số nhà, tên tòa nhà, tên đường, tên khu vực",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: Get.width * 0.9,
                        child: TextField(
                          controller: configAddressCustomerController
                              .addressDetailTextEditingController.value,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập địa chỉ cụ thể",
                          ),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 12,
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Đặt làm địa chỉ mặc định"),
                  Obx(
                    () => CustomSwitch(
                      value: configAddressCustomerController.isDefault.value,
                      onChanged: (bool val) {
                        configAddressCustomerController.isDefault.value = val;
                      },
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   height: 12,
            //   color: Colors.grey[200],
            // ),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             Container(
            //               padding: EdgeInsets.all(6),
            //               height: 40,
            //               width: 40,
            //               child: SvgPicture.asset("assets/icons/pin.svg",
            //                   color: Theme.of(context).primaryColor),
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text("Chọn vị trí trên bản đồ"),
            //                 SizedBox(
            //                   height: 3,
            //                 ),
            //                 Text(
            //                   "Giúp đơn hàng được giao nhanh nhất",
            //                   style: TextStyle(
            //                     color: Colors.grey[700],
            //                     fontSize: 12,
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ],
            //         ),
            //         Icon(Icons.arrow_forward_ios_rounded),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: 12,
              color: Colors.grey[200],
            ),
            InkWell(
              onTap: () {
                configAddressCustomerController.deleteAddressCustomer();
              },
              child: Container(
                padding: EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Xóa Địa chỉ",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 12,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        child: Column(
          children: [
            Obx(
              () => configAddressCustomerController.isLoadingUpdate.value ==
                      false
                  ? SahaButtonFullParent(
                      text: "LƯU",
                      onPressed: () {
                        configAddressCustomerController.updateAddressCustomer();
                      },
                      color: Theme.of(context).primaryColor,
                    )
                  : IgnorePointer(
                      child: SahaButtonFullParent(
                        text: "Lưu",
                        textColor: Colors.grey[600],
                        onPressed: () {},
                        color: Colors.grey[300],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
