import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/screen/config_payment/config_payment_controller.dart';

class ConfigDetailPaymentScreen extends StatelessWidget {
  final int? idPayment;
  final List<dynamic>? listDefineField;
  final List<TextEditingController>? listTextEditingController;
  Map<String, dynamic>? listFieldRequest;

  ConfigDetailPaymentScreen(
      {this.idPayment,
      this.listDefineField,
      this.listTextEditingController,
      this.listFieldRequest}) {
    configPaymentController = Get.find();
  }

  late ConfigPaymentController configPaymentController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt thanh toán"),
      ),
      body: SingleChildScrollView(
        child: idPayment == 1
            ? Column(
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
                        Icon(
                          Icons.keyboard_hide_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: listTextEditingController![0],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập Số tài khoản ngân hàng",
                            ),
                            style: TextStyle(fontSize: 15),
                            minLines: 1,
                            maxLines: 1,
                            onChanged: (v) {
                              //addTokenShipment.tokenEditingController.refresh();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              )
            : Column(
                children: [
                  ...List.generate(
                    listDefineField!.length,
                    (index) => Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          child: Row(
                            children: [
                              Icon(
                                Icons.keyboard_hide_outlined,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: listTextEditingController![index],
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Nhập ${listDefineField![index]}",
                                  ),
                                  style: TextStyle(fontSize: 15),
                                  minLines: 1,
                                  maxLines: 1,
                                  onChanged: (v) {
                                    print(
                                        listTextEditingController![index].text);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Column(
          children: [
            //addTokenShipment.tokenEditingController.value.text == ""
            false
                ? SahaButtonFullParent(
                    text: "Bật",
                  )
                : SahaButtonFullParent(
                    text: "Bật",
                    onPressed: () {
                      Map<String, dynamic> listFieldRequestCheck =
                          listFieldRequest!;
                      int i = 0;
                      listFieldRequestCheck.forEach((key, value) {
                        listFieldRequestCheck.update(
                            key,
                            (value) =>
                                value = listTextEditingController![i].text);
                        i++;
                      });
                      configPaymentController.upDatePaymentMethod(
                          idPayment, listFieldRequestCheck, true);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
