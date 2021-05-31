import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/model/combo.dart';
import 'package:sahashop_user/data/remote/response-request/marketing_chanel_response/combo/combo_request.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_combo/update_my_combo/update_combo_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_combo/update_my_combo/update_product/update_product_combo_screen.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/keyboard.dart';

class UpdateMyComboScreen extends StatefulWidget {
  Combo combo;
  bool onlyWatch;

  UpdateMyComboScreen({this.combo, this.onlyWatch});

  @override
  _UpdateMyComboScreenState createState() => _UpdateMyComboScreenState();
}

class _UpdateMyComboScreenState extends State<UpdateMyComboScreen> {
  final _formKey = GlobalKey<FormState>();

  UpdateMyComboController updateMyComboController = UpdateMyComboController();

  @override
  void initState() {
    widget.combo.productsCombo.forEach((element) {
      updateMyComboController
          .updateProductComboController.listSelectedProduct.value
          .add(element.product);

      updateMyComboController
          .updateProductComboController.listProductHasInDiscount.value
          .add(element.product);

      updateMyComboController
          .updateProductComboController.listSelectedProductParam.value
          .add(ComboProduct(
              productId: element.product.id, quantity: element.quantity));

      updateMyComboController.amountEditingController.text =
          element.quantity == null ? "" : element.quantity.toString();
    });

    updateMyComboController.nameProgramEditingController.text =
        widget.combo.name;
    updateMyComboController.dateStart.value = DateTime(
      widget.combo.startTime.year,
      widget.combo.startTime.month,
      widget.combo.startTime.day,
      widget.combo.startTime.hour,
      widget.combo.startTime.minute,
      widget.combo.startTime.second,
      widget.combo.startTime.millisecond,
      widget.combo.startTime.microsecond,
    );
    updateMyComboController.dateEnd.value = DateTime(
      widget.combo.endTime.year,
      widget.combo.endTime.month,
      widget.combo.endTime.day,
      widget.combo.endTime.hour,
      widget.combo.endTime.minute,
      widget.combo.endTime.second,
      widget.combo.endTime.millisecond,
      widget.combo.endTime.microsecond,
    );
    updateMyComboController.timeStart.value = DateTime(
      widget.combo.startTime.year,
      widget.combo.startTime.month,
      widget.combo.startTime.day,
      widget.combo.startTime.hour,
      widget.combo.startTime.minute,
      widget.combo.startTime.second,
      widget.combo.startTime.millisecond,
      widget.combo.startTime.microsecond,
    );
    updateMyComboController.timeEnd.value = DateTime(
      widget.combo.endTime.year,
      widget.combo.endTime.month,
      widget.combo.endTime.day,
      widget.combo.endTime.hour,
      widget.combo.endTime.minute,
      widget.combo.endTime.second,
      widget.combo.endTime.millisecond,
      widget.combo.endTime.microsecond,
    );
    updateMyComboController.discountTypeInput.value = widget.combo.discountType;

    updateMyComboController.valueEditingController.text =
        widget.combo.valueDiscount.toString();

    updateMyComboController.amountCodeAvailableEditingController.text =
        widget.combo.amount == null ? "" : widget.combo.amount.toString();
    updateMyComboController.checkTypeDiscountInput();
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
          title: Text('Combo khuyến mãi'),
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
                            controller: updateMyComboController
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
                                  updateMyComboController
                                      .onChangeDateStart(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(updateMyComboController.dateStart.value)}',
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
                                  '  ${SahaDateUtils().getHHMM(updateMyComboController.timeStart.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  updateMyComboController.checkDayStart.value
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
                                  updateMyComboController.onChangeDateEnd(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(updateMyComboController.dateEnd.value)}',
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
                                      updateMyComboController
                                          .onChangeTimeEnd(date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(updateMyComboController.timeEnd.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  updateMyComboController.checkDayEnd.value
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
                                  () => Container(
                                    height: 350,
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
                                                        updateMyComboController
                                                            .discountType.value,
                                                    onChanged: (v) {
                                                      updateMyComboController
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
                                            updateMyComboController
                                                        .discountType.value ==
                                                    DiscountType.k1
                                                ? Container(
                                                    height: 55,
                                                    width: Get.width * 0.85,
                                                    child: Row(
                                                      children: [
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
                                                            child: TextField(
                                                              controller:
                                                                  updateMyComboController
                                                                      .valueEditingController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
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
                                                        updateMyComboController
                                                            .discountType.value,
                                                    onChanged: (v) {
                                                      updateMyComboController
                                                          .onChangeRatio(v);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("Giảm giá theo số tiền")
                                                ],
                                              ),
                                            ),
                                            updateMyComboController
                                                        .discountType.value ==
                                                    DiscountType.k0
                                                ? Container(
                                                    width: Get.width * 0.85,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Giảm",
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
                                                            child: TextField(
                                                              controller:
                                                                  updateMyComboController
                                                                      .valueEditingController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
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
                                            updateMyComboController
                                                        .validateComboPercent
                                                        .value ==
                                                    true
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    color: Colors.red[50],
                                                    width: Get.width,
                                                    child: Text(
                                                      "Giá trị giảm là bắt buộc",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.red),
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
                                            if (updateMyComboController
                                                .valueEditingController
                                                .text
                                                .isEmpty) {
                                              updateMyComboController
                                                  .validateComboPercent
                                                  .value = true;
                                            } else {
                                              updateMyComboController
                                                  .validateComboPercent
                                                  .value = false;
                                              KeyboardUtil.hideKeyboard(
                                                  context);
                                              updateMyComboController
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
                                  updateMyComboController
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
                  updateMyComboController.isChoosedTypeVoucherDiscount.value ==
                          false
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red[50],
                          width: Get.width,
                          child: Text(
                            "Chưa chọn loại chương trình",
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
                        Text("Giới hạn combo"),
                        Container(
                          width: Get.width * 0.6,
                          child: TextFormField(
                            controller: updateMyComboController
                                .amountCodeAvailableEditingController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.length < 1) {
                                return 'Chưa nhập giới hạn combo';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Giới hạn cobom có thể sử dụng",
                            ),
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
                              Text("Combo sản phẩm"),
                              updateMyComboController
                                          .updateProductComboController
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
                                            () => UpdateProductComboScreen());
                                      })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => updateMyComboController
                                      .updateProductComboController
                                      .listSelectedProduct
                                      .value
                                      .length ==
                                  0
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => UpdateProductComboScreen());
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
                                  height: 350,
                                  child: StaggeredGridView.countBuilder(
                                    crossAxisCount: 1,
                                    scrollDirection: Axis.vertical,
                                    itemCount: updateMyComboController
                                        .updateProductComboController
                                        .listSelectedProduct
                                        .value
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Stack(
                                      children: [
                                        Row(
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
                                                imageUrl: updateMyComboController
                                                            .updateProductComboController
                                                            .listSelectedProduct
                                                            .value[index]
                                                            .images
                                                            .length ==
                                                        0
                                                    ? ""
                                                    : updateMyComboController
                                                        .updateProductComboController
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
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  IconButton(
                                                      icon: Icon(Icons.remove),
                                                      onPressed: () {
                                                        updateMyComboController
                                                            .updateProductComboController
                                                            .decreaseAmountProductCombo(
                                                                index);
                                                      }),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                        "${updateMyComboController.updateProductComboController.listSelectedProductParam.value[index].quantity}"),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  IconButton(
                                                      icon: Icon(Icons.add),
                                                      onPressed: () {
                                                        updateMyComboController
                                                            .updateProductComboController
                                                            .increaseAmountProductCombo(
                                                                index);
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          top: -10,
                                          left: -10,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              onPressed: () {
                                                updateMyComboController
                                                    .updateProductComboController
                                                    .deleteProductSelected(
                                                        updateMyComboController
                                                            .updateProductComboController
                                                            .listSelectedProduct
                                                            .value[index]
                                                            .id);
                                                updateMyComboController
                                                    .updateProductComboController
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
                () => updateMyComboController.isLoadingCreate.value == true
                    ? IgnorePointer(
                        child: SahaButtonFullParent(
                          text: "Lưu",
                          textColor: Colors.grey[600],
                          onPressed: () {},
                          color: Colors.grey[300],
                        ),
                      )
                    : widget.onlyWatch == true
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
                                if (updateMyComboController
                                        .typeVoucherDiscount.value ==
                                    "Chọn") {
                                  updateMyComboController
                                      .isChoosedTypeVoucherDiscount
                                      .value = false;
                                } else {
                                  updateMyComboController
                                      .updateCombo(widget.combo.id);
                                  updateMyComboController
                                      .isChoosedTypeVoucherDiscount
                                      .value = true;
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
