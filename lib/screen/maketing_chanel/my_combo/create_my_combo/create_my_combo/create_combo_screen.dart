import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_combo/create_my_combo/create_my_combo/create_combo_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_voucher/create_my_voucher/add_product_to_voucher/add_product_voucher_screen.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/keyboard.dart';
import 'package:sahashop_user/utils/string_utils.dart';

class CreateMyComboScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formKeyTypeVoucher = GlobalKey<FormState>();
  CreateMyComboController createMyVoucherController = CreateMyComboController();

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
          title: Text('Tạo chương '),
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
                        Text('Tên chương trình'),
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
                        Text("Loại chương trình"),
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
                                      height: 320,
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
                                                          createMyVoucherController
                                                              .discountType
                                                              .value,
                                                      onChanged: (v) {
                                                        createMyVoucherController
                                                            .onChangeRatio(v);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Giảm giá theo %")
                                                  ],
                                                ),
                                              ),
                                              createMyVoucherController
                                                          .discountType.value ==
                                                      DiscountType.k1
                                                  ? Container(
                                                      height: 55,
                                                      width: Get.width * 0.85,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Mua",
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 85,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    createMyVoucherController
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
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Số lượng"),
                                                                minLines: 1,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "& Giảm",
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 85,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    createMyVoucherController
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
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "% Giảm"),
                                                                minLines: 1,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("%"),
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
                                                          createMyVoucherController
                                                              .discountType
                                                              .value,
                                                      onChanged: (v) {
                                                        createMyVoucherController
                                                            .onChangeRatio(v);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        "Giảm giá theo số tiền")
                                                  ],
                                                ),
                                              ),
                                              createMyVoucherController
                                                          .discountType.value ==
                                                      DiscountType.k0
                                                  ? Container(
                                                      width: Get.width * 0.85,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Mua",
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 85,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    createMyVoucherController
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
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Số lượng"),
                                                                minLines: 1,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "& Giảm",
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 85,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    createMyVoucherController
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
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "đ"),
                                                                minLines: 1,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 20,
                                              ),
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
                                                createMyVoucherController
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
                                  createMyVoucherController
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
                  createMyVoucherController
                              .isChoosedTypeVoucherDiscount.value ==
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
                        Text("Giới hạn đặt hàng"),
                        Container(
                          width: Get.width * 0.6,
                          child: TextFormField(
                            controller: createMyVoucherController
                                .minimumOrderEditingController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Chưa nhập giá trị tối thiểu đơn hàng';
                              } else {
                                if (createMyVoucherController
                                    .pricePermanentEditingController
                                    .text
                                    .isEmpty) {
                                  return null;
                                } else {
                                  var myInt = int.parse(value);
                                  var pricePermanent = int.parse(
                                      createMyVoucherController
                                          .pricePermanentEditingController
                                          .text);
                                  if (myInt < pricePermanent) {
                                    createMyVoucherController
                                        .isCheckMinimumOrderDiscount
                                        .value = false;
                                    return "";
                                  } else {
                                    createMyVoucherController
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
                                  "Số lượng đặt hàng tối đa cho mỗi người",
                            ),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  createMyVoucherController.isCheckMinimumOrderDiscount.value ==
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
                  SizedBox(
                    height: 8,
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
                                          .addProductToVoucherController
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
                                        Get.to(
                                            () => AddProductToVoucherScreen());
                                      })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => createMyVoucherController
                                      .addProductToVoucherController
                                      .listSelectedProduct
                                      .value
                                      .length ==
                                  0
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => AddProductToVoucherScreen());
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
                                        .addProductToVoucherController
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
                                                        .addProductToVoucherController
                                                        .listSelectedProduct
                                                        .value[index]
                                                        .images
                                                        .length ==
                                                    0
                                                ? ""
                                                : createMyVoucherController
                                                    .addProductToVoucherController
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
                                                    .addProductToVoucherController
                                                    .deleteProductSelected(
                                                        createMyVoucherController
                                                            .addProductToVoucherController
                                                            .listSelectedProduct
                                                            .value[index]
                                                            .id);
                                                createMyVoucherController
                                                    .addProductToVoucherController
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
                () => createMyVoucherController.isLoadingCreate.value == true
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
                            // createMyVoucherController
                            //     .addProductToVoucherController
                            //     .listSelectedProductToString();
                            // if (createMyVoucherController
                            //         .typeVoucherDiscount.value ==
                            //     "Chọn loại giảm giá") {
                            //   createMyVoucherController
                            //       .isChoosedTypeVoucherDiscount.value = false;
                            // } else {
                            //   createMyVoucherController
                            //       .createVoucher(voucherType); // CREATE VOUCHER
                            //   createMyVoucherController
                            //       .isChoosedTypeVoucherDiscount.value = true;
                            // }
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
