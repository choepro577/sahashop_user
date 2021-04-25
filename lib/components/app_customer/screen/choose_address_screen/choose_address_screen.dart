import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/example/info_address.dart';
import 'package:sahashop_user/components/app_customer/screen/choose_address_screen/config_address_screen.dart';
import 'package:sahashop_user/components/app_customer/screen/choose_address_screen/new_address_screen.dart';
import 'package:sahashop_user/model/info_address.dart';

class ChooseAddressScreen extends StatelessWidget {
  bool isChoose = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn địa chỉ nhận hàng"),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ConfigAddressScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "Sửa",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(LIST_ADDRESS_EXAMPLE.length,
                (index) => addressSave(context, LIST_ADDRESS_EXAMPLE[index])),
            InkWell(
              onTap: () {
                Get.to(() => NewAddressScreen());
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Thêm địa chỉ mới"),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 35,
        color: Colors.white,
      ),
    );
  }

  Widget addressSave(BuildContext context, InfoAddress infoAddress) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${infoAddress.name}",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "${infoAddress.phone}",
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                  Text(
                    "${infoAddress.addressDetail}",
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                  Text(
                    "${infoAddress.district}, ${infoAddress.wards}, ${infoAddress.city}",
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.check_outlined,
                    color: isChoose
                        ? Theme.of(context).primaryColor
                        : Colors.grey[500],
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      "assets/icons/pin.svg",
                      color: isChoose
                          ? Theme.of(context).primaryColor
                          : Colors.grey[500],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 8,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}
