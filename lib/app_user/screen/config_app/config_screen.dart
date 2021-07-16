import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/run_app.dart';
import 'package:sahashop_user/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_user/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_user/app_user/const/constant.dart';
import 'package:sahashop_user/app_user/controller/config_controller.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../saha_data_controller.dart';
import 'ui_data_config.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final ConfigController configController = Get.put(ConfigController());

  final DataAppCustomerController dataAppController =
      Get.put(DataAppCustomerController());
  final SahaDataController sahaDataController = Get.find();
  GlobalKey configShowCase = GlobalKey();

  UIDataConfig uiDataConfig = new UIDataConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Chỉnh sửa giao diện",
                style: TextStyle(fontSize: 15),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  runMainAppCustomer();
                },
                child: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/app_user/svg/config/preview.svg',
                          height: 30, width: 30),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Xem trước",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                            Container(
                              child: Column(
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
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: sahaDataController.scrollController,
                                child: Column(
                                  children: [
                                    uiDataConfig
                                                    .UIData[configController
                                                        .indexTab.value]
                                                    .listChildConfig ==
                                                null ||
                                            uiDataConfig
                                                    .UIData[configController
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
                                            children:
                                                uiDataConfig
                                                    .UIData[configController
                                                        .indexTab.value]
                                                    .listChildConfig!
                                                    .map(
                                                      (e) =>
                                                          e.editWidget == null
                                                              ? Container()
                                                              : SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.78,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            0.0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(8)),
                                                                            gradient:
                                                                                LinearGradient(
                                                                              begin: Alignment.topRight,
                                                                              end: Alignment.bottomLeft,
                                                                              stops: [
                                                                                0.1,
                                                                                0.2
                                                                              ],
                                                                              colors: [
                                                                                Theme.of(context).primaryColor.withOpacity(0.3),
                                                                                Theme.of(context).primaryColor.withOpacity(0.1)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            e.name ??
                                                                                "",
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        e.editWidget!,
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
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

  Widget showCase(
      {GlobalKey<State<StatefulWidget>>? key,
      String? title,
      String? description,
      BuildContext? context,
      Function? onTargetClick,
      required Widget child}) {
    return Showcase(
      overlayPadding: EdgeInsets.all(5),
      key: key,
      //title: title,
      description: description,
      titleTextStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.teal),
      contentPadding: EdgeInsets.all(10.0),
      showcaseBackgroundColor: Colors.teal,
      textColor: Colors.white,
      shapeBorder: CircleBorder(),
      disposeOnTap: true,
      onTargetClick: onTargetClick == null
          ? null
          : () {
              onTargetClick();
            },
      child: child,
    );
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
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/app_user/svg/config/${parentConfig.icon}",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              parentConfig.name!,
              style: TextStyle(
                  fontSize: 12,
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
