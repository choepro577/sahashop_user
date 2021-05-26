import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/app_customer/screen/config_profile_screen/config_profile_controller.dart';
import 'package:sahashop_user/components/saha_user/loading/loading_widget.dart';
import 'package:sahashop_user/model/info_customer.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class ConfigProfileScreen extends StatelessWidget {
  InfoCustomer infoCustomer;

  ConfigProfileScreen({this.infoCustomer}) {
    configProfileController =
        ConfigProfileController(infoCustomer: infoCustomer);
  }
  ConfigProfileController configProfileController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sửa hồ sơ"),
          actions: [
            GestureDetector(
              onTap: () {
                configProfileController.updateProfileCustomer();
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
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  InkWell(
                    onTap: () {
                      configProfileController.loadAssets();
                    },
                    child: Container(
                      height: 200,
                      width: Get.width,
                      child: Obx(
                        () => CachedNetworkImage(
                          height: 70,
                          width: 70,
                          imageUrl: configProfileController.linkAvatar.value,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/saha_loading.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 65,
                    child: InkWell(
                      onTap: () {
                        configProfileController.loadAssets();
                      },
                      child: Obx(
                        () => Container(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                configProfileController.isUpdatingImage.value ==
                                        true
                                    ? SahaLoadingWidget()
                                    : CachedNetworkImage(
                                        height: 70,
                                        width: 70,
                                        imageUrl: configProfileController
                                            .linkAvatar.value,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Stack(
                                          children: [
                                            configProfileController.dataImages
                                                        .value.file ==
                                                    null
                                                ? Container()
                                                : Image.file(
                                                    configProfileController
                                                        .dataImages.value.file,
                                                    width: 300,
                                                    height: 300,
                                                  ),
                                            SahaLoadingWidget(),
                                          ],
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "assets/saha_loading.png",
                                          fit: BoxFit.cover,
                                        ),
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
                                              .headline6
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
                    Text("Tên"),
                    Container(
                      width: Get.width * 0.55,
                      child: TextField(
                        controller:
                            configProfileController.nameEditingController.value,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập họ và tên"),
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
                    Text("Giới tính"),
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
                                      configProfileController
                                          .onChangeSexPicker(value);
                                    },
                                    children: const [
                                      Text('Khác'),
                                      Text('Nam'),
                                      Text('Nữ'),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(
                              () => Text(
                                configProfileController.sex.value,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
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
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ngày sinh"),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1999, 1, 1),
                                maxTime: DateTime(2050, 1, 1),
                                theme: DatePickerTheme(
                                    headerColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    itemStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    doneStyle: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                onChanged: (date) {}, onConfirm: (date) {
                              configProfileController.birthDate.value = date;
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.vi);
                          },
                          child: Obx(
                            () => Text(
                              '${SahaDateUtils().getDDMMYY(configProfileController.birthDate.value)}',
                            ),
                          ),
                        ),
                        Container(
                            height: 13,
                            width: 13,
                            child: SvgPicture.asset(
                              "assets/icons/right_arrow.svg",
                              color: Colors.black,
                            ))
                      ],
                    )
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
                    Text("Điện thoại"),
                    Container(
                      width: Get.width * 0.55,
                      child: TextField(
                        controller: configProfileController
                            .phoneEditingController.value,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập số điện thoại"),
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
                    Text("Email"),
                    Container(
                      width: Get.width * 0.55,
                      child: TextField(
                        controller: configProfileController
                            .emailEditingController.value,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập email"),
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
                    Text("Thay đổi mật khẩu"),
                    Container(
                      width: Get.width * 0.55,
                      child: TextField(
                        controller: configProfileController
                            .passwordEditingController.value,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập mật khẩu"),
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
            ],
          ),
        ),
      ),
    );
  }
}
