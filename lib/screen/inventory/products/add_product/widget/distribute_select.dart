import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:sahashop_user/components/saha_user/divide/divide.dart';
import 'package:sahashop_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_user/screen/inventory/products/add_product/widget/dropdown_string.dart';
import 'package:sahashop_user/const/constant.dart';
import 'package:sahashop_user/model/product.dart';

import 'distribute_select_controller.dart';

class DistributeSelect extends StatefulWidget {

  final Function onData;

  const DistributeSelect({Key key, this.onData}) : super(key: key);

  @override
  _DistributeSelectState createState() => _DistributeSelectState();
}

class _DistributeSelectState extends State<DistributeSelect> {
  final DistributeSelectController distributeSelectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var valid = distributeSelectController.checkValidParam();
        if(valid) {
          widget.onData(distributeSelectController.getFinalDistribute());
        }
        return distributeSelectController.checkValidParam();
      },
      child: Scaffold(
        appBar: SahaAppBar(
          titleText: "Phân loại sản phẩm",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: distributeSelectController.listDistribute
                        .toList()
                        .map((e) => buildDistribute(e))
                        .toList(),
                  ),
                  MaterialButton(
                    onPressed: () {
                      distributeSelectController.addDistribute(null);
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
                            children: [
                              Icon(Icons.add),
                              Text("Thêm thuộc tính")
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDistribute(Distributes distributes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  CustomDropDownString(
                      value: !distributeSelectController.listSuggestion
                              .contains(distributes.name)
                          ? distributeSelectController.listSuggestion.last
                          : distributes.name,
                      hint: "",
                      errorText: "",
                      onChanged: (name) {
                        distributes.name = name;
                        distributeSelectController.refresh();
                      },
                      items: distributeSelectController
                          .getListStringBuild(distributes)
                          .map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList()),
                  !distributeSelectController.listSuggestion
                          .sublist(0,
                              distributeSelectController.listSuggestion.length - 1)
                          .contains(distributes.name)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            height: 40,
                            child: SahaTextField(
                              hintText: distributes.name ?? "Tên phân loại",
                              onSubmitted: (text) {
                                distributeSelectController.editNameDistribute(
                                    distributeSelectController.listDistribute
                                        .indexOf(distributes),
                                    text);
                              },
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  children: buildListDistributes(
                    list: distributes.elementDistributes,
                    onRemove: (distribute) {
                      distributeSelectController.removeDistribute(
                          distributeSelectController.listDistribute.indexOf(distributes));
                      distributeSelectController.refresh();
                    },
                    onAdd: () {
                      inputDialog().then((value) {
                        distributeSelectController.addDistribute(value);

                        distributeSelectController.refresh();
                      });
                    },
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    child: Icon(
                      Icons.clear,
                      size: 15,
                    ),
                    onTap: () {
                      distributeSelectController.removeDistribute(
                          distributeSelectController.listDistribute.indexOf(distributes));
                    })
              ],
            )
          ],
        ),
        SizedBox(
          height: 7,
        ),
        SahaDivide()
      ],
    );
  }

  List<Widget> buildListDistributes(
      {List<ElementDistributes> list, Function onRemove, Function onAdd}) {
    var rtList = list
        .map((e) => buildItemDistribute(distribute: e, onRemove: onRemove))
        .toList();
    rtList.add(buildItemDistribute(onAdd: onAdd, isAdd: true));
    return rtList;
  }

  Widget buildItemDistribute(
      {ElementDistributes distribute,
      Function onRemove,
      Function onAdd,
      bool isAdd = false}) {
    return InkWell(
      onTap: isAdd ? onAdd : null,
      child: Container(
        margin: EdgeInsets.only(right: 8, top: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: SahaPrimaryColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isAdd ? "Thêm" : distribute.name ?? ""),
            InkWell(
                child: Icon(
                  isAdd ? Icons.add : Icons.clear,
                  size: 15,
                ),
                onTap: () {
                  isAdd ? onAdd() : onRemove(distribute);
                })
          ],
        ),
      ),
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
          title: Text('Tên'),
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
