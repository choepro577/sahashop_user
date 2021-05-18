import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/model/voucher.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/create_my_voucher/create_my_voucher_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/update_voucher/update_product_voucher/update_product_voucher_screen.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/update_voucher/update_voucher_controller.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/keyboard.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class UpdateMyVoucherScreen extends StatefulWidget {
  Voucher voucher;

  UpdateMyVoucherScreen({this.voucher});

  @override
  _UpdateMyVoucherScreenState createState() => _UpdateMyVoucherScreenState();
}

class _UpdateMyVoucherScreenState extends State<UpdateMyVoucherScreen> {
  final _formKey = GlobalKey<FormState>();

  final _formKeyTypeVoucher = GlobalKey<FormState>();

  UpdateVoucherController updateVoucherController = UpdateVoucherController();

  @override
  void initState() {
    updateVoucherController
        .updateProductVoucherController.listSelectedProduct.value
        .addAll(widget.voucher.products);
    updateVoucherController
        .updateProductVoucherController.listProductHasInDiscount.value
        .addAll(widget.voucher.products);
    updateVoucherController.nameProgramEditingController.text =
        widget.voucher.name;
    updateVoucherController.codeVoucherEditingController.text =
        widget.voucher.code;

    updateVoucherController.dateStart.value = DateTime(
      widget.voucher.startTime.year,
      widget.voucher.startTime.month,
      widget.voucher.startTime.day,
      widget.voucher.startTime.hour,
      widget.voucher.startTime.minute,
      widget.voucher.startTime.second,
      widget.voucher.startTime.millisecond,
      widget.voucher.startTime.microsecond,
    );
    updateVoucherController.dateEnd.value = DateTime(
      widget.voucher.endTime.year,
      widget.voucher.endTime.month,
      widget.voucher.endTime.day,
      widget.voucher.endTime.hour,
      widget.voucher.endTime.minute,
      widget.voucher.endTime.second,
      widget.voucher.endTime.millisecond,
      widget.voucher.endTime.microsecond,
    );
    updateVoucherController.timeStart.value = DateTime(
      widget.voucher.startTime.year,
      widget.voucher.startTime.month,
      widget.voucher.startTime.day,
      widget.voucher.startTime.hour,
      widget.voucher.startTime.minute,
      widget.voucher.startTime.second,
      widget.voucher.startTime.millisecond,
      widget.voucher.startTime.microsecond,
    );
    updateVoucherController.timeEnd.value = DateTime(
      widget.voucher.endTime.year,
      widget.voucher.endTime.month,
      widget.voucher.endTime.day,
      widget.voucher.endTime.hour,
      widget.voucher.endTime.minute,
      widget.voucher.endTime.second,
      widget.voucher.endTime.millisecond,
      widget.voucher.endTime.microsecond,
    );
    updateVoucherController.discountTypeInput.value =
        widget.voucher.discountType;
    updateVoucherController.voucherTypeInput.value = widget.voucher.voucherType;

    updateVoucherController.pricePermanentEditingController.text =
        widget.voucher.valueDiscount.toString();
    updateVoucherController.priceDiscountLimitedEditingController.text =
        widget.voucher.maxValueDiscount == null
            ? ""
            : widget.voucher.maxValueDiscount.toString();
    updateVoucherController.isLimitedPrice.value =
        widget.voucher.setLimitValueDiscount;
    updateVoucherController.minimumOrderEditingController.text =
        widget.voucher.valueLimitTotal.toString();
    updateVoucherController.amountCodeAvailableEditingController.text =
        widget.voucher.amount == null ? "" : widget.voucher.amount.toString();
    updateVoucherController.checkTypeDiscountInput();
    super.initState();
  }

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
          title: Text('Sửa chương trình khuyến mãi'),
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
                            controller: updateVoucherController
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
                        Text("Mã giảm giá"),
                        Container(
                          width: Get.width * 0.5,
                          child: TextFormField(
                            controller: updateVoucherController
                                .codeVoucherEditingController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Chưa nhập mã giảm giá';
                              } else {
                                if (SahaStringUtils()
                                    .validateCharacter(value)) {
                                  return null;
                                } else {
                                  return "Không chứa các kí tự đặc biệt";
                                }
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
                                  updateVoucherController
                                      .onChangeDateStart(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(updateVoucherController.dateStart.value)}',
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
                                  '  ${SahaDateUtils().getHHMM(updateVoucherController.timeStart.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  updateVoucherController.checkDayStart.value
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
                                  updateVoucherController.onChangeDateEnd(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(updateVoucherController.dateEnd.value)}',
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
                                      updateVoucherController
                                          .onChangeTimeEnd(date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(updateVoucherController.timeEnd.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  updateVoucherController.checkDayEnd.value
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
                                  () => Form(
                                    key: _formKeyTypeVoucher,
                                    child: Container(
                                      height: 430,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: DiscountType.k1,
                                                      groupValue:
                                                          updateVoucherController
                                                              .discountType
                                                              .value,
                                                      onChanged: (v) {
                                                        updateVoucherController
                                                            .onChangeRatio(v);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        "Giảm giá (Giá cố định)")
                                                  ],
                                                ),
                                              ),
                                              updateVoucherController
                                                          .discountType.value ==
                                                      DiscountType.k1
                                                  ? Container(
                                                      height: 55,
                                                      width: Get.width * 0.7,
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
                                                                  updateVoucherController
                                                                      .pricePermanentEditingController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                        .length <
                                                                    1) {
                                                                  return 'Chưa nhập giá trị muốn giảm';
                                                                } else {
                                                                  var myInt =
                                                                      int.parse(
                                                                          value);
                                                                  if (myInt >
                                                                      100000000) {
                                                                    return '% giảm giá không được quá 100 triệu';
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
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: DiscountType.k0,
                                                      groupValue:
                                                          updateVoucherController
                                                              .discountType
                                                              .value,
                                                      onChanged: (v) {
                                                        updateVoucherController
                                                            .onChangeRatio(v);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Giảm giá (Theo %)")
                                                  ],
                                                ),
                                              ),
                                              updateVoucherController
                                                          .discountType.value ==
                                                      DiscountType.k0
                                                  ? Container(
                                                      width: Get.width * 0.7,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      updateVoucherController
                                                                          .pricePercentEditingController,
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
                                                                          99) {
                                                                        return '% giảm giá không được quá 99 %';
                                                                      }
                                                                      return null;
                                                                    }
                                                                  },
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  decoration: InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      border: InputBorder
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
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            height: 1,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                "Giảm tối đa"),
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    updateVoucherController
                                                                        .isLimitedPrice
                                                                        .value = true;
                                                                  },
                                                                  child: updateVoucherController
                                                                              .isLimitedPrice
                                                                              .value ==
                                                                          true
                                                                      ? Container(
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Theme.of(context).primaryColor),
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "chọn mức giảm",
                                                                              style: TextStyle(
                                                                                color: Theme.of(context).primaryColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                        )
                                                                      : Container(
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.grey[600]),
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "chọn mức giảm",
                                                                              style: TextStyle(color: Colors.grey[600]),
                                                                            ),
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                        )),
                                                              Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  updateVoucherController
                                                                      .isLimitedPrice
                                                                      .value = false;
                                                                  updateVoucherController
                                                                      .priceDiscountLimitedEditingController
                                                                      .text = "";
                                                                },
                                                                child: updateVoucherController
                                                                            .isLimitedPrice
                                                                            .value ==
                                                                        false
                                                                    ? Container(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Theme.of(context).primaryColor),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Không giới hạn",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Theme.of(context).primaryColor,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.grey[600]),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Không giới hạn",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.grey[600],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                              )
                                                            ],
                                                          ),
                                                          updateVoucherController
                                                                      .isLimitedPrice
                                                                      .value ==
                                                                  true
                                                              ? Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "đ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey[600]),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              updateVoucherController.priceDiscountLimitedEditingController,
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          validator:
                                                                              (value) {
                                                                            if (value.length <
                                                                                1) {
                                                                              return 'Chưa nhập giá trị muốn giảm';
                                                                            } else {
                                                                              var myInt = int.parse(value);
                                                                              if (myInt > 100000000) {
                                                                                return 'giảm giá không được quá 100.000.000 đ';
                                                                              }
                                                                              if (myInt < 1000) {
                                                                                return 'giảm giá không nên dưới 1000 đ';
                                                                              }
                                                                              return null;
                                                                            }
                                                                          },
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          decoration: InputDecoration(
                                                                              isDense: true,
                                                                              border: InputBorder.none,
                                                                              hintText: "Nhập giá trị bạn muốn giảm"),
                                                                          minLines:
                                                                              1,
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 20,
                                                                ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          Container(
                                            height: 10,
                                            color: Colors.grey[200],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (_formKeyTypeVoucher
                                                  .currentState
                                                  .validate()) {
                                                _formKeyTypeVoucher.currentState
                                                    .save();
                                                KeyboardUtil.hideKeyboard(
                                                    context);
                                                updateVoucherController
                                                    .checkTypeDiscount();
                                                Get.back();
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  "Lưu",
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
                                  updateVoucherController
                                      .typeVoucherDiscount.value,
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
                  updateVoucherController.isChoosedTypeVoucherDiscount.value ==
                          false
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red[50],
                          width: Get.width,
                          child: Text(
                            "Chưa chọn loại giảm giá",
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        )
                      : Divider(
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
                            controller: updateVoucherController
                                .minimumOrderEditingController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Chưa nhập giá trị tối thiểu đơn hàng';
                              } else {
                                if (updateVoucherController
                                    .pricePermanentEditingController
                                    .text
                                    .isEmpty) {
                                  return null;
                                } else {
                                  var myInt = int.parse(value);
                                  var pricePermanent = int.parse(
                                      updateVoucherController
                                          .pricePermanentEditingController
                                          .text);
                                  if (myInt < pricePermanent) {
                                    updateVoucherController
                                        .isCheckMinimumOrderDiscount
                                        .value = false;
                                    return "";
                                  } else {
                                    updateVoucherController
                                        .isCheckMinimumOrderDiscount
                                        .value = true;
                                    return null;
                                  }
                                }
                              }
                            },
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
                  updateVoucherController.isCheckMinimumOrderDiscount.value ==
                          false
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red[50],
                          width: Get.width,
                          child: Text(
                            "Giá trị voucher không thể vượt quá giá trị tối thiểu của đơn hàng",
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        )
                      : Divider(
                          height: 1,
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
                            controller: updateVoucherController
                                .amountCodeAvailableEditingController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Chưa nhập số mã có thể sử dụng';
                              } else {
                                return null;
                              }
                            },
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
                                    updateVoucherController
                                        .isShowVoucher.value = true;

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
                                    updateVoucherController
                                        .isShowVoucher.value = false;

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
                                  updateVoucherController.isShowVoucher.value ==
                                          true
                                      ? Text("Hiển thị")
                                      : Text("Không hiển thị"),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  widget.voucher.voucherType == 1
                      ? Container(
                          color: Colors.white,
                          width: Get.width,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sản phẩm'),
                                    updateVoucherController
                                                .updateProductVoucherController
                                                .listSelectedProduct
                                                .value
                                                .length ==
                                            0
                                        ? Container()
                                        : IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              Get.to(() =>
                                                  UpdateProductToVoucherScreen());
                                            })
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => updateVoucherController
                                            .updateProductVoucherController
                                            .listSelectedProduct
                                            .value
                                            .length ==
                                        0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  UpdateProductToVoucherScreen());
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
                                                    color: Theme.of(context)
                                                        .primaryColor,
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
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: Colors.red[50],
                                            width: Get.width,
                                            child: Text(
                                              "Voucher sẽ chuyển sang kiểu sử dụng cho toàn Shop nếu bạn không chọn sản phẩm",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.red),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(
                                        height: 400,
                                        child: StaggeredGridView.countBuilder(
                                          crossAxisCount: 4,
                                          itemCount: updateVoucherController
                                              .updateProductVoucherController
                                              .listSelectedProduct
                                              .value
                                              .length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
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
                                                  imageUrl: updateVoucherController
                                                              .updateProductVoucherController
                                                              .listSelectedProduct
                                                              .value[index]
                                                              .images
                                                              .length ==
                                                          0
                                                      ? ""
                                                      : updateVoucherController
                                                          .updateProductVoucherController
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
                                                      updateVoucherController
                                                          .updateProductVoucherController
                                                          .deleteProductSelected(
                                                              updateVoucherController
                                                                  .updateProductVoucherController
                                                                  .listSelectedProduct
                                                                  .value[index]
                                                                  .id);
                                                      updateVoucherController
                                                          .updateProductVoucherController
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
                      : Container(),
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
                () => updateVoucherController.isLoadingCreate.value == true
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
                            updateVoucherController
                                .updateProductVoucherController
                                .listSelectedProductToString();
                            if (updateVoucherController
                                    .typeVoucherDiscount.value ==
                                "Chọn loại giảm giá") {
                              updateVoucherController
                                  .isChoosedTypeVoucherDiscount.value = false;
                            } else {
                              updateVoucherController
                                  .updateVoucher(widget.voucher.id);
                              updateVoucherController
                                  .isChoosedTypeVoucherDiscount.value = true;
                            }
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
