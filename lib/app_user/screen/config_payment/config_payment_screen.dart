import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:sahashop_user/app_user/screen/config_payment/config_detail_payment/config_detail_payment_screen.dart';
import 'package:sahashop_user/app_user/screen/config_payment/config_payment_controller.dart';

class ConfigPayment extends StatelessWidget {
  late ConfigPaymentController configPaymentController;
  @override
  Widget build(BuildContext context) {
    configPaymentController = Get.put(ConfigPaymentController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt thanh toán"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: Get.width,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/bell.svg",
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                          "Vui lòng lựa chọn phương thức thanh toán mà bạn muốn kích hoạt cho Shop."),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () => Column(
                children: [
                  ...List.generate(
                      configPaymentController.listNamePaymentMethod.length,
                      (index) {
                    return itemPayment(index);
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemPayment(int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${configPaymentController.listNamePaymentMethod[index]}"),
              Obx(
                () => CustomSwitch(
                  value: configPaymentController.listUsePaymentMethod[index],
                  onChanged: (bool val) {
                    if (configPaymentController.listUsePaymentMethod[index]!) {
                      configPaymentController.upDatePaymentMethod(
                          configPaymentController.listIdPaymentMethod[index],
                          configPaymentController.listFieldRequest[index],
                          false);
                    } else {
                      Get.to(() => ConfigDetailPaymentScreen(
                            idPayment: configPaymentController
                                .listIdPaymentMethod[index],
                            listDefineField:
                                configPaymentController.listDefineField[index],
                            listTextEditingController: configPaymentController
                                .listTextEditingController[index],
                            listFieldRequest:
                                configPaymentController.listFieldRequest[index],
                          ));
                    }
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
    );
  }
}
