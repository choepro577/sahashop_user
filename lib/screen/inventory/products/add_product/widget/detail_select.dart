import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/widget/dropdown_string.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/product.dart';

import 'detail_select_controller.dart';

class DetailSelect extends StatelessWidget {
  final DetailSelectController detailSelectController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: detailSelectController.listDetail
                      .toList()
                      .map((e) => buildDetail(e))
                      .toList(),
                )
              ],
            ),
            MaterialButton(
              onPressed: () {
                inputDialog().then((value) {
                  detailSelectController.addDetail(value);
                });
              },
              padding: EdgeInsets.all(0),
              child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: SahaPrimaryColor,
                  radius: Radius.circular(8),
                  strokeWidth: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.add), Text("Thêm thuộc tính")],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetail(Details details) {
    print(detailSelectController.  getListStringBuild());
    return Row(
      children: [
        Container(
          width: 200,
          child: CustomDropDownString(
              value: "0",
              hint: "dsda",
              errorText: "",
              items:detailSelectController.  getListStringBuild().map((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                );
              }).toList()),
        ),
      ],
    );
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = List();
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    // setState(() {
    //   _selectedTest = selectedTest;
    // });
  }

  Future inputDialog() async {
    String teamName = '';
    return showDialog(
      context: Get.context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tên thuộc tính'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }
}
