import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_controller.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_screen.dart';
import 'package:sahashop_user/utils/date_utils.dart';
import 'package:sahashop_user/utils/keyboard.dart';

class CreateMyProgram extends StatefulWidget {
  @override
  _CreateMyProgramState createState() => _CreateMyProgramState();
}

class _CreateMyProgramState extends State<CreateMyProgram> {
  final _formKey = GlobalKey<FormState>();
  DateTime dateStart = DateTime.now();
  DateTime timeStart = DateTime.now().add(Duration(hours: 1));
  DateTime dateEnd = DateTime.now();
  DateTime timeEnd = DateTime.now().add(Duration(hours: 2));
  AddProductToSaleController addProductToSaleController =
      Get.put(AddProductToSaleController());
  bool checkDayStart = false;
  bool checkDayEnd = false;
  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController discountEditingController = new TextEditingController();
  TextEditingController quantityEditingController = new TextEditingController();

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
        body: SingleChildScrollView(
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
                          controller: nameProgramEditingController,
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
                                          color: Colors.black, fontSize: 16)),
                                  onChanged: (date) {}, onConfirm: (date) {
                                if (date.isBefore(dateStart) == true) {
                                  setState(() {
                                    checkDayStart = true;
                                    dateStart = date;
                                  });
                                } else {
                                  setState(() {
                                    checkDayStart = false;
                                    dateStart = date;
                                  });
                                }
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.vi);
                            },
                            child: Text(
                              '${SahaDateUtils().getDDMMYY(dateStart)}',
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
                                        date.timeZoneOffset.inHours.toString());
                                  },
                                  onConfirm: (date) {
                                    print('confirm $date');
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.vi,
                                );
                              },
                              child: Text(
                                '  ${SahaDateUtils().getHHMM(timeStart)}',
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                checkDayStart
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
                                if (date.isBefore(dateStart) == true) {
                                  setState(() {
                                    checkDayEnd = true;
                                    dateEnd = date;
                                  });
                                } else {
                                  setState(() {
                                    checkDayEnd = false;
                                    dateEnd = date;
                                  });
                                }
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.vi);
                            },
                            child: Text(
                              '${SahaDateUtils().getDDMMYY(dateEnd)}',
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
                                        date.timeZoneOffset.inHours.toString());
                                  },
                                  onConfirm: (date) {
                                    if (date.isBefore(timeStart) == true) {
                                      setState(() {
                                        checkDayEnd = true;
                                        timeEnd = date;
                                      });
                                    } else {
                                      setState(() {
                                        checkDayEnd = false;
                                        timeEnd = date;
                                      });
                                    }
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.vi,
                                );
                              },
                              child: Text(
                                '  ${SahaDateUtils().getHHMM(timeEnd)}',
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                checkDayEnd
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
                      Text("Giảm giá"),
                      Container(
                        width: Get.width * 0.5,
                        child: TextFormField(
                          controller: discountEditingController,
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
                              hintText: "% Giảm"),
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
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Giới hạn đặt hàng"),
                      Container(
                        width: Get.width * 0.55,
                        child: TextFormField(
                          controller: quantityEditingController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.length < 1) {
                              return 'Chưa nhập số lượng';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Số lượng (Mặc định: Không giới hạn"),
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
                            Text('Sản phẩm'),
                            addProductToSaleController
                                        .listSelectedProduct.value.length ==
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
                        () => addProductToSaleController
                                    .listSelectedProduct.value.length ==
                                0
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => AddProductToSaleScreen());
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        'Thêm sản phẩm',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
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
                                  itemCount: addProductToSaleController
                                      .listSelectedProduct.value.length,
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
                                          imageUrl: addProductToSaleController
                                                      .listSelectedProduct
                                                      .value[index]
                                                      .images
                                                      .length ==
                                                  0
                                              ? ""
                                              : addProductToSaleController
                                                  .listSelectedProduct
                                                  .value[index]
                                                  .images[0]
                                                  .imageUrl,
                                          errorWidget: (context, url, error) =>
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
                                              addProductToSaleController
                                                  .deleteProductSelected(
                                                      addProductToSaleController
                                                          .listSelectedProduct
                                                          .value[index]
                                                          .id);
                                              addProductToSaleController
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
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Lưu",
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    addProductToSaleController.listSelectedProductToString();
                    addProductToSaleController.createDiscount(
                        nameProgramEditingController.text,
                        "",
                        "",
                        timeStart.toIso8601String(),
                        timeEnd.toIso8601String(),
                        int.parse(discountEditingController.text),
                        false,
                        int.parse(quantityEditingController.text),
                        addProductToSaleController.listProductParam);
                  }
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
