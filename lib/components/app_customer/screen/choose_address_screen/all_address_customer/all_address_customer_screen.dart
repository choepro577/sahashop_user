import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/choose_address_screen/all_address_customer/all_address_customer_controller.dart';
import 'package:sahashop_user/components/app_customer/screen/choose_address_screen/config_address_customer/config_address_sreen.dart';
import 'package:sahashop_user/model/info_address_customer.dart';

// ignore: must_be_immutable
class AllAddressCustomerScreen extends StatelessWidget {
  AllAddressCustomerController allAddressCustomerController;

  bool isChoose = true;
  @override
  Widget build(BuildContext context) {
    allAddressCustomerController = AllAddressCustomerController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Địa chỉ của tôi"),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                ...List.generate(
                    allAddressCustomerController.listInfoAddressCustomer.length,
                    (index) => addressSave(
                        context,
                        allAddressCustomerController
                            .listInfoAddressCustomer[index])),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Thêm địa chỉ mới"),
                      Icon(Icons.add),
                    ],
                  ),
                ),
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 35,
          color: Colors.white,
        ));
  }

  Widget addressSave(
      BuildContext context, InfoAddressCustomer infoAddressCustomer) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => SetAddressScreen(
                  infoAddressCustomer: infoAddressCustomer,
                ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${infoAddressCustomer.name}",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "${infoAddressCustomer.phone}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    Text(
                      "${infoAddressCustomer.addressDetail}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    Text(
                      "${infoAddressCustomer.districtName}, ${infoAddressCustomer.wardsName}, ${infoAddressCustomer.provinceName}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ],
                ),
                infoAddressCustomer.isDefault
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "[Mặc định]",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
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
                    : Container()
              ],
            ),
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
