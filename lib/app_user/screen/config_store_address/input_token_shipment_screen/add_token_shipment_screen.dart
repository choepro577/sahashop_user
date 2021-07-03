import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/model/shipment.dart';
import 'package:sahashop_user/app_user/screen/config_store_address/input_token_shipment_screen/add_token_controller.dart';

class InputTokenShipmentScreen extends StatelessWidget {
  Shipment? shipment;

  late AddTokenShipment addTokenShipment;

  InputTokenShipmentScreen({this.shipment}) {
    addTokenShipment = AddTokenShipment(shipment: shipment);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt nhà vận chuyển"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            //Text("Nhập token nhà vận chuyển :"),
            Container(
              padding: EdgeInsets.all(10),
              height: 50,
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset("assets/icons/dogecoin.svg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: addTokenShipment.tokenEditingController.value,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Nhập token nhà vận chuyển",
                      ),
                      style: TextStyle(fontSize: 15),
                      minLines: 1,
                      maxLines: 1,
                      onChanged: (v) {
                        addTokenShipment.tokenEditingController.refresh();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Column(
          children: [
            Obx(() => addTokenShipment.tokenEditingController.value.text == ""
                ? SahaButtonFullParent(
                    text: "Bật",
                  )
                : SahaButtonFullParent(
                    text: "Bật",
                    onPressed: () {
                      addTokenShipment.addTokenShipment();
                    },
                  ))
          ],
        ),
      ),
    );
  }
}
