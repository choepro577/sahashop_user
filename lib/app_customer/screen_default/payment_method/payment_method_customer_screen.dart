import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen_default/payment_method/config_payment_customer_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';

class PaymentMethodCustomerScreen extends StatelessWidget {
  final Function? callback;
  final int? idPaymentCurrent;
  PaymentMethodCustomerScreen({this.callback, this.idPaymentCurrent}) {
    configPaymentCustomerController =
        ConfigPaymentCustomerController(idPaymentCurrent: idPaymentCurrent);
  }
  late ConfigPaymentCustomerController configPaymentCustomerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phương thức thanh toán"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              ...List.generate(
                configPaymentCustomerController.listNamePaymentMethod.length,
                (index) => configPaymentCustomerController
                            .listUsePaymentMethod[index] ==
                        true
                    ? Container(
                        width: Get.width,
                        color: Colors.white,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                configPaymentCustomerController
                                    .checkChooseVoucher(
                                        configPaymentCustomerController
                                            .listChoosePaymentMethod[index],
                                        index);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${configPaymentCustomerController.listNamePaymentMethod[index]}"),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  configPaymentCustomerController
                                              .listChoosePaymentMethod[index] ==
                                          null
                                      ? Container()
                                      : configPaymentCustomerController
                                              .listChoosePaymentMethod[index]
                                          ? Icon(
                                              Icons.check_sharp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : Container(),
                                  SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                            )
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
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
                    text: "Đồng ý",
                    onPressed: () {
                      callback!(
                          configPaymentCustomerController.namePaymentCurrent,
                          configPaymentCustomerController
                              .idPaymentCurrentCallBack);
                      Get.back();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
