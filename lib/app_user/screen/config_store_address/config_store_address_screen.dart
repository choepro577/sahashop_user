import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:sahashop_user/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:sahashop_user/app_user/model/shipment.dart';
import 'package:sahashop_user/app_user/screen/config_store_address/all_store_address/all_address_store_screen.dart';
import 'package:sahashop_user/app_user/screen/config_store_address/config_store_address_controller.dart';
import 'package:sahashop_user/app_user/screen/config_store_address/input_token_shipment_screen/add_token_shipment_screen.dart';

class ConfigStoreAddressScreen extends StatelessWidget {
  ConfigStoreAddressController configStoreAddressController =
      ConfigStoreAddressController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Cài đặt vận chuyển shop"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => AllAddressStoreScreen())!.then(
                      (value) => {configStoreAddressController.refreshData()});
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SahaSimmer(
                        isLoading:
                            configStoreAddressController.isLoadingAddress.value,
                        child: Container(
                          width: Get.width * 0.8,
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Địa chỉ lấy hàng',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  configStoreAddressController.listAddressStore
                                          .value.addressDetail ??
                                      "Chưa có địa chỉ chi tiết",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  configStoreAddressController.listAddressStore
                                          .value.districtName ??
                                      "Chưa có Quận/Huyện",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  configStoreAddressController
                                          .listAddressStore.value.wardsName ??
                                      "Chưa có Phường/Xã",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  configStoreAddressController.listAddressStore
                                          .value.provinceName ??
                                      "Chưa có Tỉnh/Thành phố",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ),
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
              ),
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
                            "Vui lòng lựa chọn đơn vị vận chuyển mà bạn muốn kích hoạt cho Shop."),
                      )
                    ],
                  ),
                ),
              ),
              ...List.generate(
                  configStoreAddressController.listShipmentStore.length,
                  (index) {
                return itemShipment(index);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget itemShipment(int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(configStoreAddressController.listShipmentStore[index].name!),
              Obx(() => CustomSwitch(
                    value: configStoreAddressController
                                .listShipmentStore[index].shipperConfig ==
                            null
                        ? false
                        : configStoreAddressController
                            .listShipmentStore[index].shipperConfig!.use,
                    onChanged: (bool val) {
                      if (configStoreAddressController
                                  .listShipmentStore[index].shipperConfig !=
                              null &&
                          configStoreAddressController.listShipmentStore[index]
                                  .shipperConfig!.use ==
                              true) {
                        configStoreAddressController.addTokenShipment(
                            configStoreAddressController
                                .listShipmentStore[index].id,
                            ShipperConfig(
                              token: configStoreAddressController
                                  .listShipmentStore[index]
                                  .shipperConfig!
                                  .token,
                              use: false,
                              cod: false,
                            ));
                        configStoreAddressController.refreshData();
                      } else {
                        print(configStoreAddressController
                            .listShipmentStore[index]);
                        Get.to(() => InputTokenShipmentScreen(
                                  shipment: configStoreAddressController
                                      .listShipmentStore[index],
                                ))!
                            .then((value) =>
                                {configStoreAddressController.refreshData()});
                      }
                    },
                  )),
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
