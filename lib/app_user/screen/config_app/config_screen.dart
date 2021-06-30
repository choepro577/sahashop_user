import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/run_app.dart';
import 'package:sahashop_user/app_customer/screen/data_app_controller.dart';
import 'package:sahashop_user/app_customer/utils/thread_data.dart';
import 'package:sahashop_user/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'ui_data_config.dart';

class ConfigScreen extends StatelessWidget {
  final ConfigController configController = Get.put(ConfigController());
  final DataAppCustomerController dataAppController =
      Get.put(DataAppCustomerController()); // create DataAppController

  UIDataConfig uiDataConfig = new UIDataConfig();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: SahaAppBar(
          titleText: 'Chỉnh sửa giao diện',
          actions: [
            IconButton(
                color: Colors.blueAccent,
                icon: Icon(Icons.add_to_home_screen_sharp),
                onPressed: () {
                  runMainAppCustomer(context);
                })
          ],
        ),
        body: Obx(
          () => configController.isLoadingGet.value
              ? SahaLoadingFullScreen()
              : Column(
                  children: [
                    Expanded(
                      child: Stack(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    color: Colors.grey[200],
                                    child: ListView.builder(
                                        itemCount: uiDataConfig.UIData.length,
                                        itemBuilder: (context, index) {
                                          return buildItem(index: index);
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width *
                                          0.78,
                                      decoration:
                                          BoxDecoration(color: Colors.black12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            uiDataConfig.UIData[configController
                                                    .indexTab.value]
                                                .name!,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    uiDataConfig.UIData[configController
                                                        .indexTab.value]
                                                    .listChildConfig ==
                                                null ||
                                        uiDataConfig.UIData[configController
                                                        .indexTab.value]
                                                    .listChildConfig!
                                                    .length ==
                                                0
                                        ? Container(
                                            height: 5,
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: uiDataConfig.UIData[
                                                    configController
                                                        .indexTab.value]
                                                .listChildConfig!
                                                .map(
                                                  (e) => e.editWidget == null
                                                      ? Container()
                                                      : SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.78,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  e.name ?? "",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                e.editWidget!
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                )
                                                .toList(),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => SahaButtonFullParent(
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1!
                                .color,
                            onPressed:
                                configController.isLoadingCreate.value == true
                                    ? null
                                    : () {
                                        configController.createAppTheme();
                                        configController.updateTheme();
                                      },
                            text: configController.isLoadingCreate.value == true
                                ? "..."
                                : "Cập nhật giao diện",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
        ));
  }

  Widget buildItem({required int index}) {
    ParentConfig parentConfig = uiDataConfig.UIData[index];
    return Container(
      color: configController.indexTab.value == index
          ? Colors.white
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          configController.setTab(index);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                "assets/icons/${parentConfig.icon}",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              parentConfig.name!,
              style: TextStyle(
                  fontSize: 13,
                  color: configController.indexTab.value == index
                      ? bmColors
                      : Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
