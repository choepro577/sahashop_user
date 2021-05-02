import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_user/screen/maketing_chanel/my_program/create_my_program/add_product/add_product_screen.dart';
import 'package:sahashop_user/utils/date_utils.dart';

class CreateMyProgram extends StatefulWidget {
  @override
  _CreateMyProgramState createState() => _CreateMyProgramState();
}

class _CreateMyProgramState extends State<CreateMyProgram> {
  DateTime dateStart = DateTime.now();
  DateTime timeStart = DateTime.now().add(Duration(hours: 1));
  DateTime dateEnd = DateTime.now();
  DateTime timeEnd = DateTime.now().add(Duration(hours: 2));
  bool checkDayStart = false;
  bool checkDayEnd = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Tạo chương trình khuyến mãi'),
      ),
      body: SingleChildScrollView(
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
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Nhập tên chương trình khuyến mãi tại đây",
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
                              minTime: DateTime(2021, 1, 1),
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
                              minTime: DateTime(2021, 1, 1),
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
                    height: 25,
                    child: TextField(
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
                    height: 25,
                    child: TextField(
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
                  Text('Sản phẩm'),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => AddProductScreen());
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
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
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Lưu",
              onPressed: () {},
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
