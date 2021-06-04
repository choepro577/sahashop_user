import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/shipment_screen/shipment_customer_controller.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/components/saha_user/text/text_money.dart';
import 'package:sahashop_user/model/info_address_customer.dart';

class ShipmentCustomerScreen extends StatelessWidget {
  final InfoAddressCustomer infoAddressCustomer;
  final Function callback;
  final bool isShipmentFast;

  ShipmentCustomerScreen(
      {this.infoAddressCustomer, this.callback, this.isShipmentFast}) {
    shipmentCustomerController = ShipmentCustomerController(
        infoAddressCustomer: infoAddressCustomer,
        isShipmentInput: isShipmentFast);
  }

  ShipmentCustomerController shipmentCustomerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phương thức vận chuyển"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => shipmentCustomerController.isLoadingShipmentMethod.value
              ? SahaSimmer(
                  isLoading: true,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black,
                  ))
              : Column(
                  children: [
                    InkWell(
                      onTap: () {
                        var value = true;
                        shipmentCustomerController.changeShipmentMethod(value);
                        callback(shipmentCustomerController
                            .shipmentMethodChoose.value);
                      },
                      child: Row(
                        children: [
                          Container(
                              width: 5,
                              height: 50,
                              color: shipmentCustomerController
                                      .isShipmentFast.value
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[200]),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Vận chuyển nhanh",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("From "),
                          Obx(
                            () => SahaMoneyText(
                              price: shipmentCustomerController
                                  .listShipmentFast[0].fee
                                  .toDouble(),
                              sizeVND: 14,
                              sizeText: 14,
                            ),
                          ),
                          Spacer(),
                          shipmentCustomerController.isShipmentFast.value
                              ? Icon(
                                  Icons.check_sharp,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Obx(
                      () => shipmentCustomerController.isShipmentFast.value
                          ? Column(
                              children: [
                                ...List.generate(
                                  shipmentCustomerController
                                      .listShipmentSupperSpeed.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ),
                                              Container(
                                                height: 9,
                                                width: 9,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    "${shipmentCustomerController.listShipmentFast[index].name}"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SahaMoneyText(
                                                  price:
                                                      shipmentCustomerController
                                                          .listShipmentFast[
                                                              index]
                                                          .fee
                                                          .toDouble(),
                                                  sizeVND: 14,
                                                  sizeText: 14,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Nhận hàng trong vòng 1 tuần",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 13),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Cho phép thanh toán khi nhận hàng",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 13),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(),
                    ),
                    Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        var value = false;
                        shipmentCustomerController.changeShipmentMethod(value);
                        callback(shipmentCustomerController
                            .shipmentMethodChoose.value);
                      },
                      child: Row(
                        children: [
                          Container(
                              width: 5,
                              height: 50,
                              color: shipmentCustomerController
                                      .isShipmentFast.value
                                  ? Colors.grey[200]
                                  : Theme.of(context).primaryColor),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Vận chuyển Hoả tốc",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("From "),
                          Obx(
                            () => SahaMoneyText(
                              price: shipmentCustomerController
                                  .listShipmentSupperSpeed[0].fee
                                  .toDouble(),
                              sizeVND: 14,
                              sizeText: 14,
                            ),
                          ),
                          Spacer(),
                          shipmentCustomerController.isShipmentFast.value
                              ? Container()
                              : Icon(
                                  Icons.check_sharp,
                                  color: Theme.of(context).primaryColor,
                                ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Obx(
                      () => !shipmentCustomerController.isShipmentFast.value
                          ? Column(
                              children: [
                                ...List.generate(
                                  shipmentCustomerController
                                      .listShipmentSupperSpeed.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ),
                                              Container(
                                                height: 9,
                                                width: 9,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    "${shipmentCustomerController.listShipmentSupperSpeed[index].name}"),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SahaMoneyText(
                                                  price: shipmentCustomerController
                                                      .listShipmentSupperSpeed[
                                                          index]
                                                      .fee
                                                      .toDouble(),
                                                  sizeVND: 14,
                                                  sizeText: 14,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Nhận hàng trong vòng 1 tuần",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 13),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Cho phép thanh toán khi nhận hàng",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 13),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
