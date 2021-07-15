import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_user/app_customer/remote/response-request/store/all_store_response.dart';
import 'package:sahashop_user/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'change_store_info_controller.dart';

// ignore: must_be_immutable
class ChangeStoreInfoScreen extends StatelessWidget {
  ChangeStoreInfoScreen() {
    changeStoreInfoController = ChangeStoreInfoController();
  }
  late ChangeStoreInfoController changeStoreInfoController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sửa thông tin"),
          actions: [
            GestureDetector(
              onTap: () {
                changeStoreInfoController.updateInfoStore();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Lưu",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Obx(
            ()=> Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    InkWell(
                      onTap: () {
                        changeStoreInfoController.loadAssets();
                      },
                      child: Container(
                        height: 200,
                        width: Get.width,
                        child: Obx(
                          () => CachedNetworkImage(
                            height: 70,
                            width: 70,
                            imageUrl: changeStoreInfoController.logoUrl.value,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 65,
                      child: InkWell(
                        onTap: () {
                          changeStoreInfoController.loadAssets();
                        },
                        child: Obx(
                          () => Container(
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  changeStoreInfoController
                                              .isUpdatingImage.value ==
                                          true
                                      ? SahaLoadingWidget()
                                      : CachedNetworkImage(
                                          height: 70,
                                          width: 70,
                                          imageUrl: changeStoreInfoController
                                              .logoUrl.value,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              SahaLoadingWidget(),
                                          errorWidget: (context, url, error) =>
                                              SahaEmptyImage(),
                                        ),
                                  Positioned(
                                    bottom: 1,
                                    child: Container(
                                      height: 20,
                                      width: 100,
                                      color: Colors.black45,
                                      child: Center(
                                          child: Text(
                                        "Sửa",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6!
                                                .color),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              borderRadius: BorderRadius.circular(3000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tên cửa hàng"),
                      Container(
                        width: Get.width * 0.55,
                        child: TextField(
                          controller: changeStoreInfoController
                              .nameEditingController.value,
                          keyboardType: TextInputType.name,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập địa chỉ cửa hàng"),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Địa chỉ"),
                      Container(
                        width: Get.width * 0.55,
                        child: TextField(
                          controller: changeStoreInfoController
                              .addressEditingController.value,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập địa chỉ"),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lĩnh vực"),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffffffff),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xff999999),
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Text('Thoát'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                        ),
                                        CupertinoButton(
                                          child: Text('Xong'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 200,
                                    color: Color(0xfff7f7f7),
                                    child: CupertinoPicker(
                                      itemExtent: 32.0,
                                      backgroundColor: Colors.white,
                                      onSelectedItemChanged: (value) {
                                        changeStoreInfoController
                                            .changeType(value);

                                      },
                                      children: changeStoreInfoController
                                                  .listDataType!.length ==
                                              0
                                          ? []
                                          : changeStoreInfoController
                                              .listDataType!
                                              .map((DataTypeShop e) =>
                                                  Text("${e.name}"))
                                              .toList(),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              changeStoreInfoController.store.value.nameType ==
                                      null
                                  ? Container()
                                  : Text(
                                      changeStoreInfoController
                                              .store.value.nameType ??
                                          "",
                                      style:
                                          TextStyle(fontWeight: FontWeight.w400),
                                    ),
                              Container(
                                  height: 13,
                                  width: 13,
                                  child: SvgPicture.asset(
                                    "assets/icons/right_arrow.svg",
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
