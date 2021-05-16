import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_screen.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/my_program_controller.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/keyboard.dart';

import 'create_my_voucher_controller.dart';

class CreateMyVoucher extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Function onChange;
  CreateMyVoucherController createMyVoucherController =
      CreateMyVoucherController();

  CreateMyVoucher({this.onChange});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Tạo chương trình khuyến mãi'),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text('Tên chương trình khuyến mãi'),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: createMyVoucherController
                                .nameProgramEditingController,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Chưa nhập tên chương trình';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText:
                                  "Nhập tên chương trình khuyến mãi tại đây",
                            ),
                            style: TextStyle(fontSize: 14),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Giảm giá"),
                        Container(
                          width: Get.width * 0.5,
                          child: TextFormField(
                            controller: createMyVoucherController
                                .discountEditingController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Chưa nhập % giảm giá';
                              } else {
                                var myInt = int.parse(value);
                                if (myInt > 50) {
                                  return '% giảm giá không được quá 50 %';
                                }
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Nhập mã Voucher"),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thời gian bắt đầu'),
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
                                            color: Colors.black,
                                            fontSize: 16)), onConfirm: (date) {
                                  createMyVoucherController
                                      .onChangeDateStart(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(createMyVoucherController.dateStart.value)}',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  DatePicker.showTime12hPicker(
                                    context,
                                    showTitleActions: true,
                                    onChanged: (date) {
                                      print('change $date in time zone ' +
                                          date.timeZoneOffset.inHours
                                              .toString());
                                    },
                                    onConfirm: (date) {
                                      print('confirm $date');
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(createMyVoucherController.timeStart.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  createMyVoucherController.checkDayStart.value
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red[50],
                          width: Get.width,
                          child: Text(
                            "Vui lòng nhập thời gian bắt đầu chương trình khuyến mãi sau thời gian hiện tại",
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        )
                      : Divider(
                          height: 1,
                        ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thời gian kết thúc'),
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
                                  createMyVoucherController
                                      .onChangeDateEnd(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(createMyVoucherController.dateEnd.value)}',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  DatePicker.showTime12hPicker(
                                    context,
                                    showTitleActions: true,
                                    onChanged: (date) {
                                      print('change $date in time zone ' +
                                          date.timeZoneOffset.inHours
                                              .toString());
                                    },
                                    onConfirm: (date) {
                                      createMyVoucherController
                                          .onChangeTimeEnd(date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(createMyVoucherController.timeEnd.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  createMyVoucherController.checkDayEnd.value
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red[50],
                          width: Get.width,
                          child: Text(
                            "Thời gian kết thúc phải sau thời gian bắt đầu",
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        )
                      : Divider(
                          height: 1,
                        ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Loại giảm giá"),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Obx(
                                  () => Container(
                                    height: 400,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            createMyVoucherController
                                                .hideShowVoucher
                                                .value = "Hiển thị";
                                            Get.back();
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                        value: DiscountType.k1,
                                                        groupValue:
                                                            createMyVoucherController
                                                                .discountType
                                                                .value,
                                                        onChanged: (v) {
                                                          createMyVoucherController
                                                              .discountType
                                                              .value = v;
                                                        }),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        "Giảm giá (Giá cố định)")
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 55,
                                                width: Get.width * 0.7,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "đ",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            createMyVoucherController
                                                                .discountEditingController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        validator: (value) {
                                                          if (value.length <
                                                              1) {
                                                            return 'Chưa nhập % giảm giá';
                                                          } else {
                                                            var myInt =
                                                                int.parse(
                                                                    value);
                                                            if (myInt > 50) {
                                                              return '% giảm giá không được quá 50 %';
                                                            }
                                                            return null;
                                                          }
                                                        },
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.start,
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Nhập giá trị bạn muốn giảm"),
                                                        minLines: 1,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            createMyVoucherController
                                                .hideShowVoucher
                                                .value = "Hiển thị";

                                            Get.back();
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                        value: DiscountType.k0,
                                                        groupValue:
                                                            createMyVoucherController
                                                                .discountType
                                                                .value,
                                                        onChanged: (v) {
                                                          createMyVoucherController
                                                              .discountType
                                                              .value = v;
                                                        }),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Giảm giá (Theo %)")
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: Get.width * 0.7,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            controller:
                                                                createMyVoucherController
                                                                    .discountEditingController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (value) {
                                                              if (value.length <
                                                                  1) {
                                                                return 'Chưa nhập % giảm giá';
                                                              } else {
                                                                var myInt =
                                                                    int.parse(
                                                                        value);
                                                                if (myInt >
                                                                    50) {
                                                                  return '% giảm giá không được quá 50 %';
                                                                }
                                                                return null;
                                                              }
                                                            },
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                            textAlign:
                                                                TextAlign.start,
                                                            decoration: InputDecoration(
                                                                isDense: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    "Nhập giá trị bạn muốn giảm"),
                                                            minLines: 1,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "% Giảm",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 1,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child:
                                                          Text("Giảm tối đa"),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          height: 40,
                                                          child: Center(
                                                            child: Text(
                                                              "chọn mức giảm",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          height: 40,
                                                          child: Center(
                                                            child: Text(
                                                              "Không giới hạn",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "đ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[600]),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  createMyVoucherController
                                                                      .discountEditingController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        .length <
                                                                    1) {
                                                                  return 'Chưa nhập % giảm giá';
                                                                } else {
                                                                  var myInt =
                                                                      int.parse(
                                                                          value);
                                                                  if (myInt >
                                                                      50) {
                                                                    return '% giảm giá không được quá 50 %';
                                                                  }
                                                                  return null;
                                                                }
                                                              },
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              decoration: InputDecoration(
                                                                  isDense: true,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Nhập giá trị bạn muốn giảm"),
                                                              minLines: 1,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 10,
                                          color: Colors.grey[200],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                "Thoát",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: Get.width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Chọn loại giảm giá",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
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
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Đơn tối thiểu"),
                        Container(
                          width: Get.width * 0.7,
                          child: TextFormField(
                            controller: createMyVoucherController
                                .quantityEditingController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText:
                                    "Chọn giá trị tối thiểu của đơn hàng"),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Số mã có thể sử dụng"),
                        Container(
                          width: Get.width * 0.55,
                          child: TextFormField(
                            controller: createMyVoucherController
                                .quantityEditingController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Tổng số Mã giảm giá có thể sử dụng"),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 250,
                            color: Colors.white,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    createMyVoucherController
                                        .hideShowVoucher.value = "Hiển thị";

                                    Get.back();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Hiện thị",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Các Mã voucher được hiển thị trong phần thanh toán hóa đơn",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    createMyVoucherController.hideShowVoucher
                                        .value = "Không hiển thị";

                                    Get.back();
                                  },
                                  child: Container(
                                    height: 80,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Không hiển thị",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Các Mã voucher được ẩn đi và chỉ được sử dụng khi nhập đúng Mã voucher",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  color: Colors.grey[200],
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "Thoát",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hiển thị cho khách hàng : "),
                          Container(
                              width: Get.width * 0.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(createMyVoucherController
                                      .hideShowVoucher.value),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sản phẩm'),
                              createMyVoucherController
                                          .addProductToSaleController
                                          .listSelectedProduct
                                          .value
                                          .length ==
                                      0
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        Get.to(() => AddProductToSaleScreen());
                                      })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => createMyVoucherController
                                      .addProductToSaleController
                                      .listSelectedProduct
                                      .value
                                      .length ==
                                  0
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => AddProductToSaleScreen());
                                  },
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          'Thêm sản phẩm',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 400,
                                  child: StaggeredGridView.countBuilder(
                                    crossAxisCount: 4,
                                    itemCount: createMyVoucherController
                                        .addProductToSaleController
                                        .listSelectedProduct
                                        .value
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: createMyVoucherController
                                                        .addProductToSaleController
                                                        .listSelectedProduct
                                                        .value[index]
                                                        .images
                                                        .length ==
                                                    0
                                                ? ""
                                                : createMyVoucherController
                                                    .addProductToSaleController
                                                    .listSelectedProduct
                                                    .value[index]
                                                    .images[0]
                                                    .imageUrl,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 100,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/125256955_378512906934813_3986478930794925251_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=eb0DhpK_xWQAX_QjNYx&_nc_ht=scontent.fvca1-1.fna&oh=7454a14806922d553bf05b94f929d438&oe=60A6DD4A",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -10,
                                          right: -10,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              onPressed: () {
                                                createMyVoucherController
                                                    .addProductToSaleController
                                                    .deleteProductSelected(
                                                        createMyVoucherController
                                                            .addProductToSaleController
                                                            .listSelectedProduct
                                                            .value[index]
                                                            .id);
                                                createMyVoucherController
                                                    .addProductToSaleController
                                                    .countProductSelected();
                                              }),
                                        ),
                                      ],
                                    ),
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.fit(1),
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              Obx(
                () =>
                    createMyVoucherController.addProductToSaleController
                                .isLoadingCreate.value ==
                            true
                        ? IgnorePointer(
                            child: SahaButtonFullParent(
                              text: "Lưu",
                              textColor: Colors.grey[600],
                              onPressed: () {},
                              color: Colors.grey[300],
                            ),
                          )
                        : SahaButtonFullParent(
                            text: "Lưu",
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                KeyboardUtil.hideKeyboard(context);
                                createMyVoucherController
                                    .addProductToSaleController
                                    .listSelectedProductToString();
                                createMyVoucherController
                                    .addProductToSaleController
                                    .createDiscount(
                                        createMyVoucherController
                                            .nameProgramEditingController.text,
                                        "",
                                        "",
                                        DateTime(
                                                createMyVoucherController
                                                    .dateStart.value.year,
                                                createMyVoucherController
                                                    .dateStart.value.month,
                                                createMyVoucherController
                                                    .dateStart.value.day,
                                                createMyVoucherController
                                                    .timeStart.value.hour,
                                                createMyVoucherController
                                                    .timeStart.value.minute,
                                                createMyVoucherController
                                                    .timeStart.value.second,
                                                createMyVoucherController
                                                    .timeStart
                                                    .value
                                                    .millisecond,
                                                createMyVoucherController
                                                    .timeStart
                                                    .value
                                                    .microsecond)
                                            .toIso8601String(), //timeStart.toIso8601String(),\
                                        DateTime(
                                                createMyVoucherController.dateEnd.value.year,
                                                createMyVoucherController.dateEnd.value.month,
                                                createMyVoucherController.dateEnd.value.day,
                                                createMyVoucherController.timeEnd.value.hour,
                                                createMyVoucherController.timeEnd.value.minute,
                                                createMyVoucherController.timeEnd.value.second,
                                                createMyVoucherController.timeEnd.value.millisecond,
                                                createMyVoucherController.timeEnd.value.microsecond)
                                            .toIso8601String(),
                                        //timeEnd.toIso8601String(),
                                        int.parse(createMyVoucherController.discountEditingController.text),
                                        createMyVoucherController.quantityEditingController.text.isEmpty ? false : true,
                                        createMyVoucherController.quantityEditingController.text.isEmpty ? 0 : int.parse(createMyVoucherController.quantityEditingController.text),
                                        createMyVoucherController.addProductToSaleController.listProductParam);
                              }
                            },
                            color: Theme.of(context).primaryColor,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
